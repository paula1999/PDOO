#encoding:utf-8

require_relative 'EnemyToUI'
require_relative 'ShotResult'

module Deepspace
  class EnemyStarShip
    attr_reader :ammoPower, :damage, :loot, :name, :shieldPower

    def initialize (n, a, s, l, d)
      @name = n
      @ammoPower = a
      @shieldPower = s
      @loot = l
      @damage = d
    end

    def self.newCopy (e)
      EnemyStarShip.new(e.name, e.ammoPower, e.shieldPower, e.loot, e.damage)
    end

    def getUIversion
      return EnemyToUI.new(self)
    end

    public
    def fire
      return @ammoPower
    end

    def protection
      return @shieldPower
    end

    def receiveShot (shot)
      if @shieldPower < shot then
        return ShotResult::DONOTRESIST
      else
        return ShotResult::RESIST
      end
    end

    def to_s
      return "name: #{@name}, ammoPower: #{@ammoPower}, shieldPower: #{@shieldPower}, loot: #{@loot.to_s}, damage: #{@damage.to_s}"
    end

  end
end
