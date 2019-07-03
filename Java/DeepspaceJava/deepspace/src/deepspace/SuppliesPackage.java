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
public class SuppliesPackage {
    private float ammoPower;
    private float fuelUnits;
    private float shieldPower;

    SuppliesPackage (float a, float f, float s){
        ammoPower = a;
        fuelUnits = f;
        shieldPower = s;
    }

    SuppliesPackage (SuppliesPackage s){
        ammoPower = s.getAmmoPower();
        fuelUnits = s.getFuelUnits();
        shieldPower = s.getShieldPower();
    }

    public float getAmmoPower (){
        return ammoPower;
    }

    public float getFuelUnits (){
        return fuelUnits;
    }

    public float getShieldPower (){
        return shieldPower;
    }
    
    @Override
    public String toString(){
        String mensaje;
        mensaje = "Potencia del arma: "+this.getAmmoPower()+
                " \nPotenciador del escudo: "+this.getShieldPower()+
                " \nCombustible: "+this.getFuelUnits();
        return mensaje;
    }
}
