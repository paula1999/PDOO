#encoding:utf-8

require_relative 'SpecificDamageToUI'
require_relative 'Damage'

module Deepspace
  class SpecificDamage < Damage
    attr_reader :weapons
    public_class_method :new

    def initialize(wl, s)
      super(s)
      @weapons = Array.new(wl)
    end

    def self.newCopy
      return SpecificDamage.new(@weapons, nShields)
    end

    def getUIversion
      return SpecificDamageToUI.new(self)
    end

    def adjust(w,s)
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

      return SpecificDamage.new(aux, adjustShields(s))
    end

    private
    def arrayContainsType(w,t)
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
    def discardWeapon(w)
      i = @weapons.index(w.type)

      if i != nil
        @weapons.delete_at(i)
      end
    end

    def hasNoEffect
      return (super && @weapons.length == 0)
    end

    def to_s
      return "\nWeapons: #{@weapons.join(", ")} \n#{super}"
    end
  end
end
