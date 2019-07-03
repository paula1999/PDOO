#encoding:utf-8

module Deepspace
  class SuppliesPackage
    attr_reader :ammoPower, :fuelUnits, :shieldPower

    def initialize(armamento, combustible, energia)
      @ammoPower=armamento
      @fuelUnits=combustible
      @shieldPower=energia
    end

    def self.newCopy(s)
      new(s.ammoPower, s.fuelUnits, s.shieldPower)
    end

    public
    def to_s
      return "ammoPower: #{@ammoPower}, fuelUnits: #{@fuelUnits}, shieldPower: #{@shieldPower}"
    end

  end
end
