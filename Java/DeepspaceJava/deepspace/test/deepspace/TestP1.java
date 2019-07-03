/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

/**
 *
 * @author paula
 */
public class TestP1 {
    public static void main(String[] args) {
        Loot botin;
        SuppliesPackage supplies;
        ShieldBooster sBooster;
        Weapon arma1, arma2, arma3;
        
        // Loot:
        int i = 0;

        while (i < 3){
            botin = new Loot(i, i, i, i, i);

            System.out.format("\nBotin %d",i+1);
            System.out.format("\n  Numero de suministros: %d", botin.getNSupplies());
            System.out.format("\n  Numero de armas: %d", botin.getNWeapons());
            System.out.format("\n  Numero de escudos: %d", botin.getNShields());
            System.out.format("\n  Numero de hangares: %d", botin.getNHangars());
            System.out.format("\n  Numero de medallas: %d", botin.getNMedals());

            i += 1;
        }

        System.out.format("\n");

        // Supplies
        i = 0;

        while (i < 3){
            supplies = new SuppliesPackage(i, i, i);

            System.out.format("\nSuministro %d", i+1);
            System.out.format("\n Armamento: %f", supplies.getAmmoPower());
            System.out.format("\n Combustible: %f", supplies.getFuelUnits());
            System.out.format("\n Energia para los escudos: %f", supplies.getShieldPower());

            i += 1;
        }

        // ShieldBooster
        i = 0;

        while (i < 3){
            sBooster = new ShieldBooster("Escudo", i, i);

            System.out.format("\nShield Booster %d", i+1);
            System.out.format("\n %s", sBooster.getName());
            System.out.format("\n Boost: %f", sBooster.getBoost());
            System.out.format("\n Usos: %d", sBooster.getUses());

            i += 1;
        }

        // Weapon

        arma1 = new Weapon("laser", WeaponType.LASER, 1);
        arma2 = new Weapon("misil", WeaponType.MISSILE, 2);
        arma3 = new Weapon("plasma", WeaponType.PLASMA, 0);

        System.out.format("\n \nArma 1:");
        System.out.format("\nTipo: %s", arma1.getType());
        System.out.format("\n Usos: %d", arma1.getUses());
        System.out.format("\n Potencia: %f", arma1.power());
        System.out.format("\n Metodo useIt: ");
        System.out.format("\n %f", arma1.useIt());
        System.out.format("\n %f", arma1.useIt());
        System.out.format("\n \nArma 2:");
        System.out.format("\nTipo: %s", arma2.getType());
        System.out.format("\n Usos: %d", arma2.getUses());
        System.out.format("\n Potencia: %f", arma2.power());
        System.out.format("\n Metodo useIt: ");
        System.out.format("\n %f", arma2.useIt());
        System.out.format("\n %f", arma2.useIt());
        System.out.format("\n \nArma 3:");
        System.out.format("\nTipo: %s", arma3.getType());
        System.out.format("\n Usos: %d", arma3.getUses());
        System.out.format("\n Potencia: %f", arma3.power());
        System.out.format("\n Metodo useIt: ");
        System.out.format("\n %f", arma3.useIt());
        System.out.format("\n %f", arma3.useIt());
    }
}
