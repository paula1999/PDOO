#encoding:utf-8

require_relative 'SpaceCityToUI'

module Deepspace
  class SpaceCity < SpaceStation
    attr_reader :collaborators

    def initialize (b, rest) #rest : SpaceSation[]
      super(b.name, b.ammoPower, b.fuelUnits, b.shieldPower, b.nMedals, b.shieldBoosters, b.hangar, b.weapons, b.pendingDamage)
      @base = b
      @collaborators = rest
    end

    def getUIversion
      return SpaceCityToUI.new(self)
    end

    def fire
      suma = 0

      @collaborators.each{ |c|
        suma += c.fire
      }

      return suma + super
    end

    def protection
      suma = 0

      @collaborators.each{ |c|
        suma += c.protection
      }

      return suma + super
    end

    def setLoot (loot)
      super

      return Transformation::NOTRANSFORM
    end
  end
end
