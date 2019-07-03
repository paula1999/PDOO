/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.io.PrintStream;
import java.util.ArrayList;

/**
 *
 * @author paula
 */
public class TestP2 {
    public static void main(String[] args) {
        // Loot:
        Loot botin1 = new Loot(1, 1, 1, 1, 1);
        Loot botin2 = new Loot(2, 2, 2, 2, 2);
        Loot botin3 = new Loot(3, 3, 3, 3, 3);

        System.out.format("Botin1: %s", botin1.toString());
        System.out.format("Botin2: %s", botin2.toString());
        System.out.format("Botin3: %s", botin3.toString());

        // Supplies
        System.out.format("\n********************************************************");

        SuppliesPackage supplies1 = new SuppliesPackage(1, 1, 1);
        SuppliesPackage supplies2 = new SuppliesPackage(2, 2, 2);
        SuppliesPackage supplies3 = new SuppliesPackage(3, 3, 3);

        System.out.format("\nSupplies1: %s", supplies1.toString());
        System.out.format("\nSupplies2: %s", supplies2.toString());
        System.out.format("\nSupplies3: %s", supplies3.toString());

        // ShieldBooster
        System.out.format("\n********************************************************");

        ShieldBooster sBooster1 = new ShieldBooster("Escudo1", 3, 1);
        ShieldBooster sBooster2 = new ShieldBooster("Escudo2", 2, 3);
        ShieldBooster sBooster3 = new ShieldBooster("Escudo3", 1, 0);

        System.out.format("\nShieldBooster1: %s", sBooster1.toString());
        System.out.format("\nShieldBooster2: %s", sBooster2.toString());
        System.out.format("\nShieldBooster3: %s", sBooster3.toString());

        // Weapon
        System.out.format("\n********************************************************");

        Weapon arma1 = new Weapon("laser", WeaponType.LASER, 1);
        Weapon arma2 = new Weapon("misil", WeaponType.MISSILE, 2);
        Weapon arma3 = new Weapon("plasma", WeaponType.PLASMA, 0);

        System.out.format("\nArma1: %s", arma1.toString());
        System.out.format("\nMetodo useIt: %s", arma1.useIt());
        System.out.format("\nMetodo useIt: %s", arma1.useIt());
        System.out.format("\nArma2: %s", arma2.toString());
        System.out.format("\nMetodo useIt: %s", arma2.useIt());
        System.out.format("\nMetodo useIt: %s", arma2.useIt());
        System.out.format("\nArma3: %s", arma3.toString());
        System.out.format("\nMetodo useIt: %s", arma3.useIt());
        System.out.format("\nMetodo useIt: %s", arma3.useIt());

        // Hangar:
        System.out.format("\n********************************************************");
        Hangar hangar1 = new Hangar(5);
        hangar1.addWeapon(arma1);
        hangar1.addWeapon(arma2);
        hangar1.addShieldBooster(sBooster1);
        hangar1.addShieldBooster(sBooster2);
        hangar1.addShieldBooster(sBooster3);

        System.out.format("\n\nHANGAR: %s", hangar1.toString());
        System.out.format("\nEliminando arma en la posición 2 y shield booster en la posicion 1: ");

        hangar1.removeWeapon(2);
        hangar1.removeShieldBooster(1);

        System.out.format("\n\nHANGAR: %s", hangar1.toString());

        // Damage
        System.out.format("\n********************************************************");

        Damage daño1 = new Damage(10, 15);
        ArrayList <WeaponType> arrayWeapons1 = new ArrayList<>();
        arrayWeapons1.add(WeaponType.PLASMA);
        arrayWeapons1.add(WeaponType.MISSILE);
        arrayWeapons1.add(WeaponType.PLASMA);
        Damage daño2 = new Damage(arrayWeapons1, 2);
        Damage daño3 = daño1.adjust(hangar1.getWeapons(), hangar1.getShieldBoosters());

        System.out.format("\nDAMAGE");
        System.out.format("\nDaño 1: %s", daño1.toString());
        System.out.format("\nAjustando el daño 1...");
        System.out.format("\nDaño 1 ajustado: %s", daño3.toString());
        
        daño1.discardWeapon(arma1);

        System.out.format("\nArma 1 descargada de daño 1: ");
        System.out.format("\nDaño 1:", daño1.toString());
        System.out.format("\nPrueba de hasNoEffect:");

        ArrayList <WeaponType> arrayVacio = new ArrayList<>();
        Damage damagenull = new Damage(arrayVacio,0);

        if (damagenull.hasNoEffect())
            System.out.format("\nFunciona");

        damagenull = new Damage(0,0);

        if (damagenull.hasNoEffect())
            System.out.format("\nTambien funciona");
       
        if (!daño1.hasNoEffect())
            System.out.format("\nSigue funcionando");
       
        if (!daño2.hasNoEffect())
            System.out.format("Definitivamente funciona");

        System.out.format("\nDaño 2: %s", daño2.toString());
        System.out.format("\nAjustando el daño 2...");
        
        Damage daño2Ajustado = daño2.adjust(hangar1.getWeapons(), hangar1.getShieldBoosters());

        System.out.format("\nDaño 2 ajustado: %s", daño2Ajustado.toString());
      
        daño2.discardWeapon(arma2);

        System.out.format("\nArma 2 descargada de daño 2: ");
        System.out.format("\nDaño 2: %s", daño2.toString());

        // EnemyStarShip
        System.out.format("\n********************************************************");

        EnemyStarShip enemy1 = new EnemyStarShip("Alien", 3, 2, botin1, daño1);

        System.out.format("\nENEMYSTARSHIP");
        System.out.format("\nEl primer enemigo es: %s ", enemy1.toString());

        System.out.format("\n\n**Disparando al Alien (daño=1)**");

        ShotResult shotEnemy1 = enemy1.receiveShot(1);

        if (shotEnemy1 == ShotResult.DONOTRESIST)
          System.out.format("El enemigo no se ha resistido");
        else
          System.out.format("El enemigo se ha resistido");
        
        System.out.format("\n**Disparando al Alien (daño=3)**");

        shotEnemy1 = enemy1.receiveShot(3);

        if (shotEnemy1 == ShotResult.DONOTRESIST)
          System.out.format("El enemigo no se ha resistido");
        else
          System.out.format("El enemigo se ha resistido");
       
        // SpaceStation
        System.out.format("\n********************************************************");

        SpaceStation spaceStation1 = new SpaceStation("Paula", supplies3);

        System.out.format("\nSPACESTATION %s", spaceStation1.toString());

        spaceStation1.setPendingDamage(daño1);
        spaceStation1.move();
        spaceStation1.receiveSupplies(supplies2);
        spaceStation1.move();

        System.out.format("\nSPACESTATION %s", spaceStation1.toString());

        if (spaceStation1.validState())
            System.out.format("\nEstación en buen estado");
        
        spaceStation1.receiveHangar(hangar1);
        spaceStation1.receiveWeapon(arma2);

        if (spaceStation1.receiveWeapon(arma3))
            System.out.format("Algo falla");
       
        spaceStation1.mountWeapon(0);
        spaceStation1.mountWeapon(0);
        spaceStation1.mountWeapon(0);
        spaceStation1.mountShieldBooster(0);
        spaceStation1.mountShieldBooster(0);

        System.out.format("\nDespues de montarlo... %s", spaceStation1.toString());

        spaceStation1.getWeapons().get(0).useIt();
        spaceStation1.getWeapons().get(0).useIt();
        spaceStation1.getShieldBoosters().get(0).useIt();
        spaceStation1.cleanUpMountedItems();
        spaceStation1.discardHangar();

        System.out.format("\n\nDespues de unos usos y una limpieza: %s", spaceStation1.toString());
        
        ArrayList <WeaponType> arrayDaño = new ArrayList<>();
        Damage daño4 = new Damage(arrayDaño, 3);

        spaceStation1.setPendingDamage(daño4);
        
        System.out.format("\nDespues de recibir daño...");

        if (spaceStation1.validState())
          System.out.format("\nEstación en buen estado");
       
        // GameUniverse
        System.out.format("\n********************************************************");
        System.out.format("\nGAMEUNIVERSE");

        GameUniverse gameUniverse1 = new GameUniverse();
        EnemyStarShip enemy2 = new EnemyStarShip("Enemigo2",999,998,botin2,daño2);
        EnemyStarShip enemy3 = new EnemyStarShip("Enemigo3",0.1f,1,botin1,daño1);
        SpaceStation spaceStation2 = new SpaceStation("Albacete",supplies2);
        GameState gameStateGameUniverse1 = gameUniverse1.getState();

        System.out.format("%s", gameUniverse1.toString());
        System.out.format("\n¿Tenemos un  ganador?");

        if (gameUniverse1.haveAWinner())
            System.out.format( "Si");
        else
            System.out.format( "No");
        
        gameUniverse1.mountShieldBooster(1);
        gameUniverse1.mountWeapon(1);
        gameUniverse1.discardShieldBooster(1);
        gameUniverse1.discardWeapon(1);
        gameUniverse1.discardShieldBoosterInHangar(1);
        gameUniverse1.discardWeaponInHangar(1);
        gameUniverse1.discardHangar();

        // CardDealer
        System.out.format("\n********************************************************");
        System.out.format("\nCARDDEALER");

        CardDealer cardDealer1 = CardDealer.getInstance();
        SuppliesPackage suppliesPackageCardDealer1 = cardDealer1.nextSuppliesPackage();
        Weapon weaponCardDealer1 = cardDealer1.nextWeapon();
        ShieldBooster shieldBoosterCardDealer1 = cardDealer1.nextShieldBooster();
        Hangar hangarCardDealer1 = cardDealer1.nextHangar();
        EnemyStarShip enemyCardDealer1 = cardDealer1.nextEnemy();

        // Dice
        System.out.format("\n********************************************************");
        System.out.format("\nDICE");

        Dice dado = new Dice();
        int hangares0 = 0;
        int armas1 = 0;
        int armas2 = 0;
        int escudos0 = 0;
        int empieza0 = 0;
        int primerDisparoEstacion = 0;
        int mueveEstacion = 0;
        int i = 0;
        
        while (i < 100){
            int contador = dado.initWithNHangars();

            if (contador == 0)
                hangares0 = hangares0 + 1;
            
            contador = dado.initWithNWeapons();

            if (contador == 1)
                  armas1 = armas1 + 1;
            else if (contador == 2)
                  armas2 = armas2 + 1;
            
            contador = dado.initWithNShields();

            if (contador == 0)
                escudos0 = escudos0 + 1;
           
            contador = dado.whoStarts(2);

            if (contador == 0)
                empieza0 = empieza0 + 1;
           
            if (dado.firstShot() == GameCharacter.SPACESTATION)
                primerDisparoEstacion = primerDisparoEstacion + 1;
            
            if (dado.spaceStationMoves(0.5f))
                mueveEstacion = mueveEstacion + 1;
            
            i += 1;
        }

        System.out.format("\nResultados de las 100 iteraciones: ");
        System.out.format("\nSe ha obtenido en %d", hangares0);
        System.out.format(" el resultado de 0 hangares, que tenía prob de 0.25.");
        System.out.format("\nSe ha obtenido en %d", armas1);
        System.out.format(" el resultado de 1 arma, que tenía prob de 0.33.");
        System.out.format("\nSe ha obtenido en %d", armas2);
        System.out.format( " el resultado de 2 armas, que tenía prob de 0.33.");
        System.out.format( "\nSe ha obtenido en %d", (100-armas1-armas2));
        System.out.format( " de las 100 veces el resultado de 3 armas, que tenía prob de 0.33.");
        System.out.format( "\nSe ha obtenido en %d ", escudos0);
        System.out.format( " el resultado de 0 escudos, que tenía prob de 0.25.");
        System.out.format( "\nSe ha obtenido en %d", empieza0);
        System.out.format( " que empieza el jugador 0, que tenía prob de 0.5.");
        System.out.format( "\nSe ha obtenido en %d", primerDisparoEstacion);
        System.out.format( " de las 100 veces que primero dispara la estación, que tenía prob de 0.5.");
        System.out.format( "\nSe ha obtenido en %d", mueveEstacion);
        System.out.format( " de las 100 veces que la estación se mueve, que tenía prob de 0.5.\n");
    }
}
