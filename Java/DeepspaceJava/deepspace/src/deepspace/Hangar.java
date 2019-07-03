/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.ArrayList;

/**
 *
 * @author paula
 */
public class Hangar {
    private int maxElements;
    private ArrayList<Weapon> weapons;
    private ArrayList<ShieldBooster> shieldBoosters;

    Hangar (int capacity){
        maxElements = capacity;
        weapons = new ArrayList<>();
        shieldBoosters = new ArrayList<>();
        shieldBoosters = new ArrayList<>();
    }

    Hangar (Hangar h){
        maxElements = h.getMaxElements();
        weapons = new ArrayList<>();
        weapons = h.getWeapons();
        shieldBoosters = new ArrayList<>();
        shieldBoosters = h.getShieldBoosters();
    }
            
    public int getMaxElements (){
        return maxElements;
    }
    
    public ArrayList<Weapon> getWeapons (){
        return weapons;
    }
    
    public ArrayList<ShieldBooster> getShieldBoosters (){
        return shieldBoosters;
    }
    
    public HangarToUI getUIversion (){
      return new HangarToUI(this);
    }

    private boolean spaceAvailable (){
        if ((weapons.size() + shieldBoosters.size()) < maxElements)
            return true;
        else
            return false;
    }

    public boolean addWeapon (Weapon w){
        if (spaceAvailable()){
            weapons.add(w);
            return true;
        }
        else
            return false;
    }

    public boolean addShieldBooster (ShieldBooster s){
        if (spaceAvailable()){
            shieldBoosters.add(s);
            return true;
        }
        else
            return false;
    }

    public ShieldBooster removeShieldBooster (int s){
        if (s>=shieldBoosters.size())
            return null;
        else{
            return shieldBoosters.remove(s);
        }
    }
    
    public Weapon removeWeapon (int w){
        if (w>=weapons.size())
            return null;
        else{
            return weapons.remove(w);
        }
    }
    
    @Override
    public String toString(){
        String res="Armas:\n "+weapons.toString()+
                "  \nPotenciadores de escudo:\n"+shieldBoosters.toString()+
                "\nElementos maximos: "+maxElements;
        return res;
    }
}
