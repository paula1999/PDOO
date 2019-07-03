#encoding:utf-8

require_relative 'HangarToUI.rb'

module Deepspace
  class Hangar
    attr_reader :maxElements, :weapons, :shieldBoosters

    def initialize (m)
      @maxElements = m
      @weapons = Array.new
      @shieldBoosters = Array.new
    end

    def self.newCopy (h)
      copy = Hangar.new(h.maxElements)

      h.weapons.each { |w|
        copy.weapons.push(Weapon.newCopy(w))
      }

      h.shieldBoosters.each { |s|
        copy.shieldBoosters.push(ShieldBooster.newCopy(s))
      }
      return copy
    end

    def getUIversion
      return HangarToUI.new(self)
    end

    private
    def spaceAvailable
      if ((@weapons.length + @shieldBoosters.length) < @maxElements) then
        return true
      else
        return false
      end
    end

    public
    def addWeapon (w)
      if spaceAvailable then
        @weapons.push(w);
        return true;
      else
        return false;
      end
    end

    def addShieldBooster (s)
      if spaceAvailable then
        @shieldBoosters.push(s)
      end
    end

    def removeShieldBooster (s)
      if (s >= @shieldBoosters.length || s < 0) then
        return nil
      else
        return @shieldBoosters.delete_at(s)
      end
    end

    def removeWeapon (w)
      if (w >= @weapons.length || w < 0) then
        return nil
      else
        return @weapons.delete_at(w)
      end
    end

    def to_s
      cad = "maxElements: #{@maxElements}"
      cad += "\nArmas: \n"

      @weapons.each{ |w|
        cad += w.to_s
        cad += "\n"
      }

      cad += "\nShieldBoosters: \n"

      @shieldBoosters.each{ |s|
        cad += s.to_s
        cad += "\n"
      }

      return cad
    end

  end
end
