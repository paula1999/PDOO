#encoding:utf-8

require_relative 'PowerEfficientSpaceStationToUI'

module Deepspace;
  class PowerEfficientSpaceStation < SpaceStation
    @@EFFICIENCYFACTOR = 1.1

    def initialize (station)
      super(station.name, station.ammoPower, station.fuelUnits, station.shieldPower, station.nMedals, station.shieldBoosters, station.hangar, station.weapons, station.pendingDamage)
    end

    def getUIversion
      return PowerEfficientSpaceStationToUI.new(self)
    end

    def fire
      return super*@@EFFICIENCYFACTOR
    end

    def protection
      return super*@@EFFICIENCYFACTOR
    end

    def setLoot (loot)
      if super == Transformation::GETEFFICIENT
        return Transformation::GETEFFICIENT
      else
        return Transformation::NOTRANSFORM
      end
    end
  end # class

end # module
