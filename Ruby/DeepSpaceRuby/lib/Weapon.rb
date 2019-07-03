#encoding:utf-8
require_relative 'WeaponToUI'

module Deepspace
  class Weapon
    attr_reader :type, :uses, :name

    def initialize(n,t,u)
      @name = n
      @type = t
      @uses = u
    end

    def self.newCopy(w)
      new(w.name, w.type, w.uses)
    end

    public
    def power
      return @type.power
    end

    def useIt
      if @uses > 0 then
        @uses -= 1
        return power
      else
        return 1.0
      end
    end

    def to_s
      return "Nombre del arma: #{@name}, Tipo: #{@type}, Uses: #{@uses}"
    end

    def getUIversion
      return WeaponToUI.new(self)
    end
  end
end
