#encoding:utf-8

require_relative 'SpaceStationToUI'
require_relative 'Transformation'

module Deepspace
  class SpaceStation
    @@MAXFUEL = 100
    @@SHIELDLOSSPERUNITSHOT = 0.1

    attr_reader :ammoPower, :fuelUnits, :hangar, :name, :nMedals, :pendingDamage, :shieldBoosters, :shieldPower, :weapons

    def initialize (n, ap, fu, sp, nm=0, sb=[], h=nil, w=[], pd=nil)
      @name = n
      @ammoPower = ap
      assignFuelValue(fu)
      @nMedals = nm
      @shieldBoosters = sb
      @hangar = h
      @weapons = w
      @shieldPower = sp
      @pendingDamage = pd
    end

    def self.newStation(n,s)
      new(n,s.ammoPower,s.fuelUnits,s.shieldPower)
    end

    def self.newCopy(station)
      stationCopy = SpaceStation.new(station.name, station.ammoPower, station.fuelUnits, station.shieldPower, station.nMedals, station.shieldBoosters, station.hangar, station.weapons, station.pendingDamage)
      stationCopy
    end

    private
    def assignFuelValue (f)
      if f > @@MAXFUEL then
        @fuelUnits = @@MAXFUEL
      else
        @fuelUnits = f
      end
    end

    def cleanPendingDamage
      if @pendingDamage != nil && @pendingDamage.hasNoEffect then
        @pendingDamage = nil
      end
    end

    public
    def cleanUpMountedItems
      i = 0

      while i < @weapons.length do
        if @weapons[i].uses <= 0 then
          @weapons.delete_at(i)
        end

        i +=1
      end

      i = 0

      while i < @shieldBoosters.length do
        if @shieldBoosters[i].uses <= 0 then
          @shieldBoosters.delete_at(i)
        end

        i += 1
      end
    end

    def discardHangar
      @hangar = nil
    end

    def discardShieldBooster (i)
      if (i >= 0 && i < @shieldBoosters.size) then
        @shieldBoosters.delete_at(i)

        if @pendingDamage != nil then
          @pendingDamage.discardShieldBooster
          cleanPendingDamage
        end
      end
    end

    def discardShieldBoosterInHangar (i)
      if @hangar != nil then
        @hangar.removeShieldBooster(i)
      end
    end

    def discardWeapon (i)
      if (i >= 0 && i < @weapons.size) then
        w = @weapons.delete_at(i)

        if @pendingDamage != nil then
          @pendingDamage.discardWeapon(w)
          cleanPendingDamage
        end
      end
    end

    def discardWeaponInHangar (i)
      if @hangar != nil then
        @hangar.removeWeapon(i)
      end
    end

    def fire
      factor = 1

      if !@weapons.empty? then
        for i in 0..@weapons.length-1
          w = @weapons.at(i)
          factor *= w.useIt
        end
      end

      factor *= @ammoPower

      return factor
    end

    def speed
      return (@fuelUnits.to_f/@@MAXFUEL.to_f)
    end

    def getUIversion
      return SpaceStationToUI.new(self)
    end

    def mountShieldBooster (i)
      if @hangar != nil then
        shield = @hangar.removeShieldBooster(i)

        if shield != nil then
          @shieldBoosters.push(shield)
        end
      end
    end

    def mountWeapon (i)
      if @hangar != nil then
        weapon = @hangar.removeWeapon(i)

        if weapon != nil then
          @weapons.push(weapon)
        end
      end
    end

    def move
      @fuelUnits = @fuelUnits.to_f - (@fuelUnits.to_f * speed() )

      if @fuelUnits < 0 then
        @fuelUnits = 0
      end
    end

    def protection
      factor = 1

      if !@shieldBoosters.empty? then
        for i in 0..@shieldBoosters.length-1
          s = @shieldBoosters.at(i)
          factor *= s.useIt
        end
      end

      factor *= @shieldPower

      return factor
    end

    def receiveHangar (n)
      if @hangar == nil then
        @hangar = n
      end
    end

    def receiveShieldBooster (s)
      if @hangar != nil then
        return @hangar.addShieldBooster(s)
      else
        return false
      end
    end

    def receiveShot (shot)
      myProtection = protection

      if myProtection >= shot then
        @shieldPower -= @@SHIELDLOSSPERUNITSHOT * shot
        @shieldPower = [0.0, @shieldPower].max

        return ShotResult::RESIST
      else
        @shieldPower = 0.0

        return ShotResult::DONOTRESIST
      end
    end

    def receiveSupplies (s)
      @ammoPower += s.ammoPower()
      @fuelUnits += s.fuelUnits()
      @shieldPower += s.shieldPower()

      if @fuelUnits > @@MAXFUEL then
        @fuelUnits = @@MAXFUEL
      end
    end

    def receiveWeapon (w)
      if @hangar != nil then
        return @hangar.addWeapon(w)
      else
        return false
      end
    end

    def setLoot (loot)
      dealer = CardDealer.instance
      h = loot.nHangars

      if h > 0 then
        @hangar = dealer.nextHangar
        receiveHangar(@hangar)
      end

      elements = loot.nSupplies

      for i in 0..(elements - 1)
        sup = dealer.nextSuppliesPackage
        receiveSupplies(sup)
      end

      elements = loot.nWeapons

      for j in 0..(elements - 1)
        weap = dealer.nextWeapon
        receiveWeapon(weap)
      end

      elements = loot.nShields

      for k in 0..(elements - 1)
        sh = dealer.nextShieldBooster
        receiveShieldBooster(sh)
      end

      medals = loot.nMedals

      @nMedals += medals

      if loot.spaceCity
        return Transformation::SPACECITY
      elsif loot.efficient
        return Transformation::GETEFFICIENT
      else
        return Transformation::NOTRANSFORM
      end
    end

    def setPendingDamage (d)
      @pendingDamage = d.adjust(@weapons, @shieldBoosters)
    end

    def validState
      cleanPendingDamage

      if @pendingDamage == nil then
        return true
      else
        return false
      end
    end

    def to_s
      cad = "maxFuel: #{@@MAXFUEL}, shielLossPerUnitShot: #{@@SHIELDLOSSPERUNITSHOT}"
      cad += "\nammoPower: #{@ammoPower}, fuelUnits: #{@fuelUnits}, name: #{@name}, nMedals: #{@nMedals}"
      cad += "\nweapons: "

      @weapons.each{ |w|
        cad += w.to_s
      }

      cad += "\nshieldBoosters: "

      @shieldBoosters.each{ |sB|
        cad += sB.to_s
      }

      cad += "\nhangar: #{@hangar.to_s}"
      cad += "\nshieldPower: #{@shieldPower}, pendingDamage: #{@pendingDamage.to_s}"

      return cad
    end

  end
end
