/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;

/**
 *
 * @author paula
 */
public class SpecificDamage extends Damage {
    private ArrayList<WeaponType> weapons = new ArrayList<>();

    SpecificDamage (ArrayList<WeaponType> w, int ns){
        super(ns);
        weapons = w;
    }
    
    @Override
    public SpecificDamage copy (){
        return (new SpecificDamage(new ArrayList<WeaponType>(weapons), getNShields()));
    }
    
    public SpecificDamageToUI getUIversion (){
        return new SpecificDamageToUI(this);
    }
    
    @Override
    public SpecificDamage adjust (ArrayList<Weapon> w, ArrayList<ShieldBooster> s){
        ArrayList<WeaponType> aux = new ArrayList<>();
        ArrayList<WeaponType> result = new ArrayList<>();
          
        for (Weapon elemento:w)
            aux.add(elemento.getType());
               
        WeaponType wtypes [] = WeaponType.values();
        
        for (int i=0; i<wtypes.length; i+=1) {
            int min = Math.min(Collections.frequency(aux, wtypes[i]), Collections.frequency(weapons, wtypes[i]));
            
            for (int j = 0; j < min; j+=1)
                result.add(wtypes[i]);
        } 
        
        return new SpecificDamage(result, adjustShields(s));
    }
    
    public ArrayList<WeaponType> getWeapons (){
        return weapons;
    }
    
    @Override
    public void discardWeapon (Weapon w){
        weapons.remove(w.getType());
    }
    
    @Override
    public boolean hasNoEffect (){
        return (weapons.size() == 0 && super.hasNoEffect());
    }
    
    @Override
    public String toString (){
        return "Weapons: " + weapons + super.toString();
    }
}
