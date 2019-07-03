#encoding:utf-8

require_relative 'GameCharacter'

module Deepspace
  class Dice
    def initialize
      @NHANGARSPROB = 0.25
      @NSHIELDSPROB = 0.25
      @NWEAPONSPROB = 0.33
      @FIRSTSHOTPROB = 0.5
      @EXTRAEFFICIENCY = 0.8
      @generator = Random.new
    end

    def extraEfficiency
      r = @generator.rand(1.0)

      return r < @EXTRAEFFICIENCY
    end

    def initWithNHangars
      if @generator.rand(1.0) >= @NHANGARSPROB then
        return 1
      else
        return 0
      end
    end

    def initWithNWeapons
      prob = @generator.rand(1.0)

      if prob < @NWEAPONSPROB then
        return 1
      elsif prob < 2*@NWEAPONSPROB then
        return 2
      else
        return 3
      end
    end

    def initWithNShields
      prob = @generator.rand(1.0)

      if prob < @NSHIELDSPROB then
        return 0
      else
        return 1
      end
    end

    def whoStarts (p)
      player = @generator.rand(p)

      return player
    end

    def firstShot
      prob = @generator.rand(1.0)

      if prob <= @FIRSTSHOTPROB then
        return GameCharacter::SPACESTATION
      else
        return GameCharacter::ENEMYSTARSHIP
      end

    end

    def spaceStationMoves (s)
      prob = @generator.rand(1.0)

      if prob <= s then
        return true
      else
        return false
      end
    end

    def to_s
      return "NHANGARSPROB: #{@NHANGARSPROB}, NSHIELDSPROB: #{@NSHIELDSPROB}, NWEAPONSPROB: #{@NWEAPONSPROB}, FIRSTSHOTPROB: #{@FIRSTSHOTPROB}"
    end

  end
end
