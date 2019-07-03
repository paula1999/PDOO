/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author paula
 */
public class NumericDamage extends Damage{
    private int nWeapons;

    NumericDamage (int w, int ns){
        super(ns);
        nWeapons = w;
    }
    
    @Override
    public NumericDamage copy (){
        return (new NumericDamage(nWeapons, getNShields()));
    }
    
    public NumericDamageToUI getUIversion (){
        return new NumericDamageToUI(this);
    }

    @Override
    public NumericDamage adjust (ArrayList<Weapon> w, ArrayList<ShieldBooster> s){
        return new NumericDamage(Math.min(nWeapons, w.size()), super.adjustShields(s));
    }
    
    public int getNWeapons (){
        return nWeapons;
    }
    
    @Override
    public void discardWeapon (Weapon w){
        if(nWeapons != 0)
             nWeapons--;
    }
    
    @Override
    public boolean hasNoEffect (){
        return nWeapons == 0 && super.hasNoEffect();
    }
    
    @Override
    public String toString (){
        return "nWeapons: " + nWeapons + super.toString();
    }
}
