#encoding:utf-8

require_relative 'DamageToUI'
require_relative 'EnemyStarShip'
require_relative 'SpaceStation'
require_relative 'WeaponType'
require_relative 'Weapon'

=begin
module Deepspace
  class Damage
    attr_reader :nShields, :nWeapons, :weapons

    def initialize (s, w, wl)
      @nShields = s
      @nWeapons = w
      @weapons = wl
    end

    def self.newNumericWeapons (w, s)
      new(s, w, nil)
    end

    def self.newSpecificWeapons (wl, s)
      new(s, -1, wl)
    end

    def self.newCopy (d)
      if d.nWeapons == -1 then
        return newSpecificWeapons(d.weapons, d.nShields)
      else
        return newNumericWeapons(d.nWeapons, d.nShields)
      end
    end

    def getUIversion
      return DamageToUI.new(self)
    end

    def arrayContainsType (w, t)
      i = 0
      salir = false

      while i < w.length && !salir do
         if w[i].type == t then
           salir = true
         end
         i += 1
      end

      if !salir then
        return -1
      else
        return i
      end
    end

    public
    def adjust (w, s)
      if @nWeapons == -1 then
        weaponTypes = []

        w.each{|elem|
          weaponTypes.push(elem.type)
        }

        # intersección
        aux = weaponTypes & @weapons

        for i in 0...aux.length
          k = [weaponTypes.count(aux[i]), @weapons.count(aux[i])].min

          for j in 2..k
            aux.push(aux[i])
          end
        end

        return Damage.newSpecificWeapons(aux, [@nShields, s.size].min)
      else
        return Damage.newNumericWeapons([@nWeapons,w.size].min, [@nShields, s.size].min)
      end
    end

    def discardWeapon (w)
      if @weapons != nil then
        i = @weapons.index(w.type)

        if i != nil
          @weapons.delete_at(i)
        end
      else
        if @nWeapons > 0 then
          @nWeapons -= 1
        end
      end
    end

    def discardShieldBooster
      if (@nShields > 0) then
        @nShields = @nShields - 1
      end
    end

    def hasNoEffect
      if @nWeapons != -1 then
        if @nWeapons == 0 && @nShields == 0 then
          return true
        else
          return false
        end
      else
        if @weapons.size == 0 && @nShields == 0 then
          return true
        else
          return false
        end
      end
    end

    def to_s
      if nWeapons != -1 then
        return "nWeapons: #{@nWeapons}, nShields: #{@nShields}"
      else
        cad = "Weapons: "

        @weapons.each{ |arma|
          cad += "#{arma}"
          cad += ", "
        }

        cad += "\nnShields: #{@nShields}"
        return cad
      end
    end

    private_class_method :new

  end

end
=end
