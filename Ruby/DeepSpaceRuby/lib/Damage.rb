#encoding:utf-8

require_relative 'DamageToUI'

module Deepspace
  class Damage
    attr_reader :nShields

    def initialize (s)
      @nShields = s
    end

    def self.newCopy
    end

    def getUIversion
      return DamageToUI.new(self)
    end

    public
    def adjust (w, s)
    end

    def adjustShields(s)
      return [@nShields, s.size].min
    end

    def discardWeapon (w)
    end

    def discardShieldBooster
      if (@nShields > 0) then
        @nShields = @nShields - 1
      end
    end

    def hasNoEffect
      return (@nShields <= 0)
    end

    def to_s
      return "\nnShields: #{@nShields}"
    end

    private_class_method :new
  end
end
