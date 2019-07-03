#encoding:utf-8
require_relative 'LootToUI.rb'

module Deepspace
  class Loot
    attr_reader :nSupplies, :nWeapons, :nShields, :nHangars, :nMedals, :efficient, :spaceCity

    def initialize(nsu, nw, nsh, nh, nm, ef=false, city=false)
      @nSupplies = nsu
      @nWeapons = nw
      @nShields = nsh
      @nHangars = nh
      @nMedals = nm
      @efficient = ef
      @spaceCity = city
    end

    public
    def to_s
      return "nSupplies: #{@nSupplies}, nWeapons: #{@nWeapons}, nShields: #{@nShields}, nHangars: #{@nHangars}, nMedals: #{@nMedals}"
    end

    def getUIversion
      return LootToUI.new(self)
    end

  end
end
