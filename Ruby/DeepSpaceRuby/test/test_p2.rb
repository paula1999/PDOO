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
require '../lib/GameUniverse'
require '../lib/CardDealer'

module Pruebas
  class TestP2
    def self.main
      # Loot:
      botin1 = Deepspace::Loot.new(1, 1, 1, 1, 1)
      botin2 = Deepspace::Loot.new(2, 2, 2, 2, 2)
      botin3 = Deepspace::Loot.new(3, 3, 3, 3, 3)

      puts "Botin1: "
      puts botin1.to_s
      puts "Botin2: "
      puts botin2.to_s
      puts "Botin3: "
      puts botin3.to_s

      # Supplies
      puts "\n********************************************************"

      supplies1 = Deepspace::SuppliesPackage.new(1, 1, 1)
      supplies2 = Deepspace::SuppliesPackage.new(2, 2, 2)
      supplies3 = Deepspace::SuppliesPackage.new(3, 3, 3)

      puts "\nSupplies1: "
      puts supplies1.to_s
      puts "\nSupplies2: "
      puts supplies2.to_s
      puts "\nSupplies3: "
      puts supplies3.to_s

      # ShieldBooster
      puts "\n********************************************************"

      sBooster1 = Deepspace::ShieldBooster.new("Escudo1", 3, 1)
      sBooster2 = Deepspace::ShieldBooster.new("Escudo2", 2, 3)
      sBooster3 = Deepspace::ShieldBooster.new("Escudo3", 1, 0)

      puts "\nShieldBooster1: "
      puts sBooster1.to_s
      puts "\nShieldBooster2: "
      puts sBooster2.to_s
      puts "\nShieldBooster3: "
      puts sBooster3.to_s

      # Weapon
      puts "\n********************************************************"

      arma1 = Deepspace::Weapon.new("laser", Deepspace::WeaponType::LASER, 1)
      arma2 = Deepspace::Weapon.new("misil", Deepspace::WeaponType::MISSILE, 2)
      arma3 = Deepspace::Weapon.new("plasma", Deepspace::WeaponType::PLASMA, 0)

      puts "Arma1:"
      puts arma1.to_s
      puts "Metodo useIt: "
      puts arma1.useIt
      puts arma1.useIt

      puts "Arma2:"
      puts arma2.to_s
      puts "Metodo useIt: "
      puts arma2.useIt
      puts arma2.useIt

      puts "Arma3:"
      puts arma3.to_s
      puts "Metodo useIt: "
      puts arma3.useIt
      puts arma3.useIt

      # Hangar:
      puts "\n********************************************************"
      hangar1 = Deepspace::Hangar.new(5)
      hangar1.addWeapon(arma1)
      hangar1.addWeapon(arma2)
      hangar1.addShieldBooster(sBooster1)
      hangar1.addShieldBooster(sBooster2)
      hangar1.addShieldBooster(sBooster3)

      puts "\n\nHANGAR:"
      puts hangar1.to_s

      puts "\nEliminando arma en la posición 2 y shield booster en la posicion 1: "

      hangar1.removeWeapon(2)
      hangar1.removeShieldBooster(1)

      puts hangar1.to_s

      # Damage
      puts "\n********************************************************"

      daño1 = Deepspace::Damage.newNumericWeapons(10, 15)
      arrayWeapons1 = [Deepspace::WeaponType::PLASMA, Deepspace::WeaponType::MISSILE, Deepspace::WeaponType::PLASMA]
      daño2 = Deepspace::Damage.newSpecificWeapons(arrayWeapons1, 2)
      daño3 = daño1.adjust(hangar1.weapons, hangar1.shieldBoosters)

      puts "\nDAMAGE"
      puts "\nDaño 1:"
      puts daño1.to_s
      puts "\nAjustando el daño 1..."
      puts "\nDaño 1 ajustado:"
      puts daño3.to_s

      daño1.discardWeapon(arma1)

      puts "\nArma 1 descargada de daño 1: "
      puts "\nDaño 1:"
      puts daño1.to_s
      puts"\nPrueba de hasNoEffect:"

      damagenull = Deepspace::Damage.newSpecificWeapons([],0)

      if damagenull.hasNoEffect then
        puts "Funciona"
      end

      damagenull = Deepspace::Damage.newNumericWeapons(0,0)

      if damagenull.hasNoEffect then
        puts "Tambien funciona"
      end

      if !daño1.hasNoEffect then
        puts "Sigue funcionando"
      end

      if !daño2.hasNoEffect then
        puts "Definitivamente funciona"
      end

      puts "\nDaño 2:"
      puts daño2.to_s
      puts "\nAjustando el daño 2..."

      daño2Ajustado = daño2.adjust(hangar1.weapons, hangar1.shieldBoosters)

      puts "\nDaño 2 ajustado:"
      puts daño2Ajustado.to_s

      daño2.discardWeapon(arma2)

      puts "\nArma 2 descargada de daño 2: "
      puts "\nDaño 2:"
      puts daño2.to_s
      puts"\nPrueba de hasNoEffect:"

      # EnemyStarShip
      puts "\n********************************************************"

      enemy1 = Deepspace::EnemyStarShip.new("Alien", 3, 2, botin1, daño1)

      puts "\nENEMYSTARSHIP"
      puts "\nEl primer enemigo es:"
      puts enemy1.to_s

      puts "\n\n**Disparando al Alien (daño=1)**"

      shotEnemy1 = enemy1.receiveShot(1)

      if shotEnemy1 == Deepspace::ShotResult::DONOTRESIST then
        puts "El enemigo no se ha resistido"
      else
        puts "El enemigo se ha resistido"
      end

      puts "\n**Disparando al Alien (daño=3)**"

      shotEnemy1 = enemy1.receiveShot(3)

      if shotEnemy1 == Deepspace::ShotResult::DONOTRESIST
        puts "El enemigo no se ha resistido"
      else
        puts "El enemigo se ha resistido"
      end

      # SpaceStation
      puts "\n********************************************************"

      spaceStation1 = Deepspace::SpaceStation.new("Paula", supplies3)

      puts "\nSPACESTATION"
      puts spaceStation1.to_s

      spaceStation1.setPendingDamage(daño1)
      spaceStation1.move
      spaceStation1.receiveSupplies(supplies2)
      spaceStation1.move

      puts "\nSPACESTATION"
      puts spaceStation1.to_s

      if spaceStation1.validState then
        puts "\nEstación en buen estado"
      end

      spaceStation1.receiveHangar(hangar1)
      spaceStation1.receiveWeapon(arma2)

      if spaceStation1.receiveWeapon(arma3)
        puts "Algo falla"
      end

      spaceStation1.mountWeapon(0)
      spaceStation1.mountWeapon(0)
      spaceStation1.mountWeapon(0)
      spaceStation1.mountShieldBooster(0)
      spaceStation1.mountShieldBooster(0)

      puts "\nDespues de montarlo..."
      puts spaceStation1.to_s

      spaceStation1.weapons.at(0).useIt
      spaceStation1.weapons.at(0).useIt
      spaceStation1.shieldBoosters.at(0).useIt
      spaceStation1.cleanUpMountedItems
      spaceStation1.discardHangar

      puts "\n\nDespues de unos usos y una limpieza:"
      puts spaceStation1.to_s

      spaceStation1.setPendingDamage(Deepspace::Damage.newSpecificWeapons([Deepspace::WeaponType::PLASMA, Deepspace::WeaponType::LASER, Deepspace::WeaponType::MISSILE], 3))

      puts "\nDespues de recibir daño..."

      if spaceStation1.validState then
        puts "\nEstación en buen estado"
      end

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

      gameUniverse1.mountShieldBooster(sBooster2)
      gameUniverse1.mountWeapon(arma2)
      gameUniverse1.discardShieldBooster(1)
      gameUniverse1.discardWeapon(1)
      gameUniverse1.discardShieldBoosterInHangar(1)
      gameUniverse1.discardWeaponInHangar(1)
      gameUniverse1.discardHangar

      # CardDealer
      puts "\n********************************************************"
      puts "\nCARDDEALER"

      cardDealer1 = Deepspace::CardDealer.instance
      suppliesPackageCardDealer1 = cardDealer1.nextSuppliesPackage
      weaponCardDealer1 = cardDealer1.nextWeapon
      shieldBoosterCardDealer1 = cardDealer1.nextShieldBooster
      hangarCardDealer1 = cardDealer1.nextHangar
      enemyCardDealer1 = cardDealer1.nextEnemy

      # Dice
      puts "\n********************************************************"
      puts "\nDICE"

      dado = Deepspace::Dice.new
      hangares0 = 0;
      armas1 = 0;
      armas2 = 0;
      escudos0 = 0;
      empieza0 = 0;
      primerDisparoEstacion = 0;
      mueveEstacion = 0;

      100.times do
          contador = dado.initWithNHangars

          if contador == 0
            hangares0 = hangares0 + 1
          end

          contador = dado.initWithNWeapons

          if contador == 1
                armas1 = armas1 + 1
          elsif contador == 2
                armas2 = armas2 + 1
          end

          contador = dado.initWithNShields

          if contador == 0
              escudos0 = escudos0 + 1
          end

          contador = dado.whoStarts(2);

          if contador == 0
              empieza0 = empieza0 + 1
          end

          if dado.firstShot == Deepspace::GameCharacter::SPACESTATION
              primerDisparoEstacion = primerDisparoEstacion + 1
          end

          if dado.spaceStationMoves(0.5)
              mueveEstacion = mueveEstacion + 1
          end

      end

      print "\nResultados de las 100 iteraciones: "

      print "\nSe ha obtenido en " + hangares0.to_s + " de las 100 veces"
      print " el resultado de 0 hangares, que tenía prob de 0.25."

      print "\nSe ha obtenido en " + armas1.to_s + " de las 100 veces"
      print " el resultado de 1 arma, que tenía prob de 0.33."

      print "\nSe ha obtenido en " + armas2.to_s + " de las 100 veces"
      print " el resultado de 2 armas, que tenía prob de 0.33."

      print "\nSe ha obtenido en " + (100-armas1-armas2).to_s
      print " de las 100 veces el resultado de 3 armas, que tenía prob "
      print " de 0.33."

      print "\nSe ha obtenido en " + escudos0.to_s + " de las 100 veces"
      print " el resultado de 0 escudos, que tenía prob de 0.25."

      print "\nSe ha obtenido en " + empieza0.to_s + " de las 100 veces"
      print " que empieza el jugador 0, que tenía prob de 0.5."

      print "\nSe ha obtenido en " + primerDisparoEstacion.to_s
      print " de las 100 veces que primero dispara la estación, que "
      print "tenía prob de 0.5."

      print "\nSe ha obtenido en " + mueveEstacion.to_s
      print " de las 100 veces que la estación se mueve, que tenía "
      print " prob de 0.5.\n"

    end
  end

  TestP2.main
end
