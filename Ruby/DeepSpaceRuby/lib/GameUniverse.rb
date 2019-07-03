#encoding:utf-8

require_relative 'GameUniverseToUI'
require_relative 'Dice'
require_relative 'GameStateController'
require_relative 'CardDealer'
require_relative 'CombatResult'
require_relative 'SpaceStation'
require_relative 'EnemyStarShip'
require_relative 'PowerEfficientSpaceStation'
require_relative 'BetaPowerEfficientSpaceStation'
require_relative 'SpaceCity'

module Deepspace
  class GameUniverse
    @@WIN = 10

    def initialize
      @turns = 0
      @gameState = GameStateController.new
      @currentStationIndex = -1
      @dice = Dice.new
      @currentStation = nil
      @spaceStations = Array.new
      @currentEnemy = nil
      @haveSpaceCity = false
    end

    public
    def combatGo (station, enemy)
      ch = @dice.firstShot

      if ch == GameCharacter::ENEMYSTARSHIP then
        fire = enemy.fire
        result = station.receiveShot(fire)

        if result == ShotResult::RESIST then
          fire = station.fire
          result = enemy.receiveShot(fire)
          enemyWins = (result==ShotResult::RESIST)
        else
          enemyWins = true
        end
      else
        fire = station.fire
        result = enemy.receiveShot(fire)
        enemyWins = (result==ShotResult::RESIST)
      end

      if enemyWins then
        s = station.speed
        moves = @dice.spaceStationMoves(s)

        if !moves then
          damage = enemy.damage
          station.setPendingDamage(damage)
          combatResult = CombatResult::ENEMYWINS
        else
          station.move
          combatResult = CombatResult::STATIONESCAPES
        end
      else
        aLoot = enemy.loot
        transf = station.setLoot(aLoot)
        combatResult = CombatResult::STATIONWINSANDCONVERTS

        if transf == Transformation::GETEFFICIENT then
          makeStationEfficient
        elsif transf == Transformation::SPACECITY && !@haveSpaceCity then
          createSpaceCity
        else
          combatResult = CombatResult::STATIONWINS
        end
      end

      @gameState.next(@turns, @spaceStations.size())

      combatResult
    end

    def combat
      if ((state == GameState::BEFORECOMBAT) || (state == GameState::INIT)) then
        combatGo(@currentStation, @currentEnemy)
      else
         CombatResult::NOCOMBAT
      end
    end

    def createSpaceCity
      if !@haveSpaceCity then
        rest = Array.new

        @spaceStations.each{ |s|
          if s != @currentStation then
            rest.push(s)
          end
        }

        @currentStation = SpaceCity.new(@currentStation, rest)
        @spaceStations[@currentStationIndex] = @currentStation
        @haveSpaceCity = true
      end
    end

    def discardHangar
      if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT
        @currentStation.discardHangar
      end
    end

    def discardShieldBooster (i)
      if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT then
        @currentStation.discardShieldBooster(i)
      end
    end

    def discardShieldBoosterInHangar(i)
      if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT then
        @currentStation.discardShieldBoosterInHangar(i)
      end
    end

    def discardWeapon (i)
      if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT then
        @currentStation.discardWeapon(i)
      end
    end

    def discardWeaponInHangar (i)
      if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT then
        @currentStation.discardWeaponInHangar(i)
      end
    end

    def state
      return @gameState.state
    end

    def getUIversion
      return GameUniverseToUI.new(@currentStation, @currentEnemy)
    end

    def haveAWinner
      if @currentStation != nil then
        return (@currentStation.nMedals >= @@WIN)
      else
        return false
      end
    end

    def init (names)
      if state == GameState::CANNOTPLAY then
        dealer = CardDealer.instance

        for i in 0..(names.length-1)
          supplies = dealer.nextSuppliesPackage
          station = SpaceStation.new(names[i], supplies.ammoPower, supplies.fuelUnits, supplies.shieldPower)
          @spaceStations.push(station)
          nh = @dice.initWithNHangars
          nw = @dice.initWithNWeapons
          ns = @dice.initWithNShields
          lo = Loot.new(0, nw, ns, nh, 0)
          station.setLoot(lo)
        end

        @currentStationIndex = @dice.whoStarts(names.size)
        @currentStation = @spaceStations[@currentStationIndex]
        @currentEnemy = dealer.nextEnemy
        @gameState.next(@turns, @spaceStations.size)
      end
    end

    def makeStationEfficient
      if @dice.extraEfficiency then
        @currentStation = BetaPowerEfficientSpaceStation.new(@currentStation)
      else
        @currentStation = PowerEfficientSpaceStation.new(@currentStation)
      end

      @spaceStations[@currentStationIndex] = @currentStation
    end

    def mountShieldBooster (i)
      if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT then
        @currentStation.mountShieldBooster(i)
      end
    end

    def mountWeapon (i)
      if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT then
        @currentStation.mountWeapon(i)
      end
    end

    def nextTurn
      if state == GameState::AFTERCOMBAT then
        stationState = @currentStation.validState

        if stationState then
          @currentStationIndex = (@currentStationIndex + 1) % @spaceStations.size
          @turns += 1
          @currentStation = @spaceStations[@currentStationIndex]
          @currentStation.cleanUpMountedItems
          dealer = CardDealer.instance
          @currentEnemy = dealer.nextEnemy
          @gameState.next(@turns, @spaceStations.size)

          return true
        end

        return false

      end

      return false
    end

    def to_s
      cad = "tuns: #{@turns}, gameState: #{@gameState.state.to_s}, currentStationIndex: #{@currentStationIndex}"
      cad +=  "dice: #{@dice.to_s}, currentStation: #{@currentStation.to_s}, currentEnemy: #{@currentEnemy}"
      cad += "\nOtras estaciones: \n"

      @spaceStations.each{ |sStation|
        if sStation != @currentStation
          cad += sStation.to_s
        end
      }

      return cad
    end

  end
end
