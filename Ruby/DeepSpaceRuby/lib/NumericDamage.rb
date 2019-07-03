#encoding:utf-8

require_relative 'NumericDamageToUI'
require_relative 'Damage'

module Deepspace
  class NumericDamage < Damage
    attr_reader :nWeapons
    public_class_method :new

    def initialize(w,s)
      super(s)
      @nWeapons = w
    end

    def self.newCopy
      return NumericDamage.new(@nWeapons, nShields)
    end

    def getUIversion
      return NumericDamageToUI.new(self)
    end

    def adjust(w,s)
      return NumericDamage.new([@nWeapons,w.size].min, adjustShields(s))
    end

    def discardWeapon(w)
      if @nWeapons > 0 then
        @nWeapons -= 1
      end
    end

    def hasNoEffect
      return (super && nWeapons <= 0)
    end

    def to_s
      "\nnWeapons: #{@nWeapons} \n#{super}"
    end
  end
end
