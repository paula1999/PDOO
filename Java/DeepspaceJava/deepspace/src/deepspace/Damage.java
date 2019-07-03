/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.ArrayList;
import java.util.Iterator;

/**
 *
 * @author paula
 */
abstract class Damage {
    private int nShields;

    Damage (int s){
        nShields = s;
    }
    
    public int getNShields (){
        return nShields;
    }
 
    abstract Damage copy ();
    
    abstract DamageToUI getUIversion ();

    abstract Damage adjust (ArrayList<Weapon> w, ArrayList<ShieldBooster> s);
    
    public int adjustShields (ArrayList<ShieldBooster> s){
        return Math.min(s.size(), nShields);
    }

    abstract void discardWeapon (Weapon w);

    public void discardShieldBooster (){
        if (nShields > 0)
            nShields -= 1;
    }

    public boolean hasNoEffect (){
        return nShields == 0;
    }
    
    @Override
    public String toString(){
        return "nShields: " + nShields;
    }
}
