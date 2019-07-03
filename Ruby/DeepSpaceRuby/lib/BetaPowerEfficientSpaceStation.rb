#encoding:utf-8

require_relative 'BetaPowerEfficientSpaceStationToUI'
require_relative 'Dice'

module Deepspace
  class BetaPowerEfficientSpaceStation < PowerEfficientSpaceStation
    @@EXTRAEFFICIENCY = 1.2

    def initialize (station)
      super(station)
      @dice = Dice.new
    end

    def getUIversion
      return BetaPowerEfficientSpaceStationToUI.new(self)
    end

    def fire
      factor = 1.0

      if @dice.extraEfficiency
        factor = @@EXTRAEFFICIENCY
      end

      return super*factor
    end
  end # class

end # module
