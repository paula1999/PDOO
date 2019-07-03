#encoding:utf-8

require '../lib/CombatResult'
require '../lib/Dice'
require '../lib/GameCharacter'
require '../lib/Loot'
require '../lib/ShieldBooster'
require '../lib/ShotResult'
require '../lib/SpaceStation'
require '../lib/SuppliesPackage'
require '../lib/Weapon'
require '../lib/WeaponType'
require '../lib/Hangar'
require '../lib/Damage'
require '../lib/EnemyStarShip'
require '../lib/CardDeck'
require '../lib/CardDealer'

module Pruebas
  class TestP3
    def self.main
      # SpaceStation
      puts "\n********************************************************"

      supplies1 = Deepspace::SuppliesPackage.new(3, 3, 3)
      supplies2 = Deepspace::SuppliesPackage.new(2, 2, 2)
      arma2 = Deepspace::Weapon.new("misil", Deepspace::WeaponType::MISSILE, 2)
      arma3 = Deepspace::Weapon.new("plasma", Deepspace::WeaponType::PLASMA, 0)
      daño1 = Deepspace::Damage.newNumericWeapons(10, 15)
      hangar1 = Deepspace::Hangar.new(5)
      hangar1.addWeapon(arma3)
      hangar1.addWeapon(arma2)
      sBooster1 = Deepspace::ShieldBooster.new("Escudo1", 3, 1)
      sBooster2 = Deepspace::ShieldBooster.new("Escudo2", 2, 3)
      sBooster3 = Deepspace::ShieldBooster.new("Escudo3", 1, 0)
      hangar1.addShieldBooster(sBooster1)
      hangar1.addShieldBooster(sBooster2)
      hangar1.addShieldBooster(sBooster3)
      spaceStation1 = Deepspace::SpaceStation.new("Paula", supplies1)
      botin1 = Deepspace::Loot.new(1, 1, 1, 1, 1)
      botin2 = Deepspace::Loot.new(2, 2, 2, 2, 2)
      botin3 = Deepspace::Loot.new(3, 3, 3, 3, 3)
      arrayWeapons1 = [Deepspace::WeaponType::PLASMA, Deepspace::WeaponType::MISSILE, Deepspace::WeaponType::PLASMA]
      daño2 = Deepspace::Damage.newSpecificWeapons(arrayWeapons1, 2)

      puts "\nSPACESTATION"
      puts spaceStation1.to_s

      puts "Después de setPendingDamage + receiveSupplies: "

      spaceStation1.setPendingDamage(daño1)
      spaceStation1.move
      spaceStation1.receiveSupplies(supplies2)
      spaceStation1.move

      puts "\nSPACESTATION"
      puts spaceStation1.to_s

      if spaceStation1.validState then
        puts "\nEstación en buen estado"
      end

      puts "Después de receiveHangar + receiveWeapon: "

      spaceStation1.receiveHangar(hangar1)
      spaceStation1.receiveWeapon(arma2)

      disparo = spaceStation1.fire

      puts "Disparo: "
      puts disparo.to_s

      proteccion = spaceStation1.protection

      puts "Proteccion: "
      puts proteccion.to_s

      puts "\nSPACESTATION"
      puts spaceStation1.to_s

      if Deepspace::ShotResult::RESIST == spaceStation1.receiveShot(disparo) then
        puts "\nLa estación espacial ha resistido al disparo"
      else
        puts "\nLa estación espacial no ha resistido al disparo"
      end

      puts "\nSPACESTATION"
      puts spaceStation1.to_s

      puts "Despues de setLoot: "

      spaceStation1.setLoot(botin3)

      puts "\nSPACESTATION"
      puts spaceStation1.to_s

      puts "Despues de mountWeapon + mountShieldBooster: "

      i = 0

      while i < spaceStation1.hangar.weapons.size  do
        spaceStation1.mountWeapon(0)
      end

      while i < spaceStation1.hangar.shieldBoosters.size  do
        spaceStation1.mountShieldBooster(0)
      end

      puts "\nSPACESTATION"
      puts spaceStation1.to_s

      puts "Después de discardWeapon: "

      spaceStation1.discardWeapon(1)

      puts "\nSPACESTATION"
      puts spaceStation1.to_s

      puts "Después de discardShieldBooster: "

      spaceStation1.discardShieldBooster(1)

      puts "\nSPACESTATION"
      puts spaceStation1.to_s

      # GameUniverse
      puts "\n********************************************************"
      puts "\nGAMEUNIVERSE"

      gameUniverse1 = Deepspace::GameUniverse.new
      enemy2 = Deepspace::EnemyStarShip.new("Enemigo2",999,998,botin2,daño2)
      enemy3 = Deepspace::EnemyStarShip.new("Enemigo3",0.1,1,botin1,daño1)
      spaceStation2 = Deepspace::SpaceStation.new("Albacete",supplies2)
      gameStateGameUniverse1 = gameUniverse1.state

      puts gameUniverse1.to_s
      puts "\n¿Tenemos un  ganador?"

      if (gameUniverse1.haveAWinner)
        puts "Si"
      else
        puts "No"
      end

      puts "Después de mountShieldBooster + mountWeapon + discardShieldBooster + discardWeapon + discardShieldBoosterInHangar + discardWeaponInHangar + discardHangar"

      gameUniverse1.mountShieldBooster(sBooster2)
      gameUniverse1.mountWeapon(arma2)
      gameUniverse1.discardShieldBooster(1)
      gameUniverse1.discardWeapon(1)
      gameUniverse1.discardShieldBoosterInHangar(1)
      gameUniverse1.discardWeaponInHangar(1)
      gameUniverse1.discardHangar

      puts gameUniverse1.to_s
      puts "Después de init: "

      nombresJugadores = ["Paula", "Nuria", "Pepe"]

      gameUniverse1.init(nombresJugadores)

      puts gameUniverse1.to_s

      if gameUniverse1.nextTurn then
        puts "Siguiente turno"
      else
        puts "No se puede cambiar de turno"
      end

      puts gameUniverse1.combat.to_s

    end
  end

  TestP3.main
end
