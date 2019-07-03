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
public class EnemyStarShip {
    private String name;
    private float ammoPower;
    private float shieldPower;
    private Loot loot;
    private Damage damage;

    EnemyStarShip (String n, float a, float s,Loot l,Damage d){
        name = n;
        ammoPower = a;
        shieldPower = s;
        loot = l;
        damage = d;
    }

    EnemyStarShip (EnemyStarShip e){
        name = e.getName();
        ammoPower = e.getAmmoPower();
        shieldPower = e.getShieldPower();
        loot = e.getLoot();
        damage = e.getDamage();
    }

    public String getName (){
        return name;
    }
    
    public float getAmmoPower (){
        return ammoPower;
    }
    
    public float getShieldPower (){
        return shieldPower;
    }
    
    public Loot getLoot (){
        return loot;
    }
    
    public Damage getDamage (){
        return damage;
    }
            
    public EnemyToUI getUIversion (){
        return new EnemyToUI(this);
    }

    public  float fire (){
        return ammoPower;
    }

    public float protection (){
        return shieldPower;
    }

    public ShotResult receiveShot (float shot){
        if (shieldPower < shot) 
            return ShotResult.DONOTRESIST;
        else
            return ShotResult.RESIST;
    }
    
    @Override
    public String toString(){
        String mensaje="Nombre:"+name+
                        ",\npoder del armas:"+ammoPower+
                        ",\npoder del escudo: "+shieldPower+
                        ",\nbotin:"+loot.toString()+
                        ",\ndaño:"+damage.toString();
        return mensaje;
    }
}
