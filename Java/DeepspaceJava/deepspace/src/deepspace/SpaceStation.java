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
public class SpaceStation implements SpaceFighter {
    private static final int MAXFUEL = 100;
    private static final float SHIELDLOSSPERUNITSHOT = 0.1f;
    private float ammoPower;
    private float fuelUnits;
    private String name;
    private int nMedals;
    private ArrayList<ShieldBooster> shieldBoosters = new ArrayList<>();
    private Hangar hangar;
    private ArrayList<Weapon> weapons = new ArrayList<>();
    private float shieldPower;
    private Damage pendingDamage;

    SpaceStation (String n, SuppliesPackage s){
        ammoPower = s.getAmmoPower();
        fuelUnits = s.getFuelUnits();
        name = n;
        nMedals = 0;
        hangar = null;
        shieldPower = s.getShieldPower();
        pendingDamage = null;
    }
    
    SpaceStation (SpaceStation station){
        this(station.name, new SuppliesPackage(station.ammoPower, station.fuelUnits, station.shieldPower));
        nMedals = station.nMedals;
        weapons = new ArrayList(station.weapons);
        shieldBoosters = new ArrayList(station.shieldBoosters);
        hangar = null;
        
        if (station.hangar != null)
            hangar = new Hangar(station.hangar);
        
        pendingDamage = null;
  
        if(station.pendingDamage != null)
            pendingDamage = station.pendingDamage.copy();
    }
    
    public float getAmmoPower (){
        return ammoPower;
    }
    
    public float getFuelUnits (){
        return fuelUnits;
    }
    
    public Hangar getHangar (){
        return hangar;
    }
    
    public String getName (){
        return name;
    }
    
    public int getNMedals (){
        return nMedals;
    }
    
    public Damage getPendingDamage (){
        return pendingDamage;
    }
    
    public ArrayList<ShieldBooster> getShieldBoosters (){
        return shieldBoosters;
    }
    
    public float getShieldPower (){
        return shieldPower;
    }
    
    public ArrayList<Weapon> getWeapons (){
        return weapons;
    }

    private void assignFuelValue (float f){
        fuelUnits = f;
    }

    private void cleanPendingDamage (){
        if (pendingDamage.hasNoEffect())
            pendingDamage = null;
    }

    public void cleanUpMountedItems (){
        int i;
        
        if (weapons != null){
            i = 0;
            while (i<weapons.size()){
                if (weapons.get(i).getUses() == 0){
                    weapons.remove(i);
                }
                else{
                    i++;
                }
            }
        }
        
        i = 0;
        while (i<shieldBoosters.size()){
            if (shieldBoosters.get(i).getUses() == 0){
                shieldBoosters.remove(i);
            }
            else{
                i++;
            }
        }
    }

    public void discardHangar (){
        hangar = null;
    }

    public void discardShieldBooster (int i){
        if (i >= 0 && i< shieldBoosters.size()){
            ShieldBooster s = shieldBoosters.remove(i);

            if (pendingDamage != null){
                pendingDamage.discardShieldBooster();
                cleanPendingDamage();
            }
        }
    }

    public void discardShieldBoosterInHangar (int i){
        if (hangar != null)
            hangar.removeShieldBooster(i);
    }

    public void discardWeapon (int i){
        if (i >= 0 && i< weapons.size()){
            Weapon w = weapons.remove(i);

            if (pendingDamage != null){
                pendingDamage.discardWeapon(w);
                cleanPendingDamage();
            }
        }
    }
    

    public void discardWeaponInHangar (int i){
        if (hangar != null)
            hangar.removeWeapon(i);
    }

    public float fire (){
        float factor = 1;
        Weapon w;
        
        if (!weapons.isEmpty()){
            for (int i=0; i<weapons.size(); i++){
                w = weapons.get(i);
                factor *= w.useIt();
            }
        }
        
        factor *= ammoPower;
        
        return factor;
    }

    public float getSpeed (){
        return fuelUnits/MAXFUEL;
    }

    public SpaceStationToUI getUIversion (){
        return new SpaceStationToUI(this);
    }

    public void mountShieldBooster (int i){
        if (hangar != null && i >= 0) {
            ShieldBooster shield = hangar.removeShieldBooster(i);

            if (shield != null)
                shieldBoosters.add(shield);
        }
    }

    public void mountWeapon (int i){
        if (hangar != null && i >= 0){
            Weapon weapon = hangar.removeWeapon(i);

            if (weapon != null)
                weapons.add(weapon);
        }
    }

    public void move (){
        fuelUnits = fuelUnits - (fuelUnits * getSpeed());

        if (fuelUnits < 0)
            fuelUnits = 0;
    }

    public float protection (){
        float factor = 1;
        ShieldBooster s;
        
        if (!shieldBoosters.isEmpty()){
            for (int i=0; i<shieldBoosters.size(); i++){
                s = shieldBoosters.get(i);
                factor *= s.useIt();
            }
        }
        
        factor *= ammoPower;
        
        return factor;
    }

    public void receiveHangar (Hangar h){
        if (hangar == null)
            hangar = h; 
    }

    public boolean receiveShieldBooster (ShieldBooster s){
        if (hangar != null)
            return hangar.addShieldBooster(s);
        else
            return false;
    }

    public ShotResult receiveShot (float shot){
        float myProtection = protection();
        
        if (myProtection >= shot){
            shieldPower -= SHIELDLOSSPERUNITSHOT * shot;
            
            if (shieldPower < 0.0f)
                shieldPower = 0.0f;
            
            return ShotResult.RESIST;          
        }
        else{
            shieldPower = 0.0f;
            
            return ShotResult.DONOTRESIST;
        }
    }   

    public void receiveSupplies (SuppliesPackage s){
        ammoPower += s.getAmmoPower();
        fuelUnits += s.getFuelUnits();
        shieldPower += s.getShieldPower();
    }

    public boolean receiveWeapon (Weapon w){
        if (hangar != null)
            return hangar.addWeapon(w);
        else
            return false;
    }

    public Transformation setLoot (Loot loot){
        CardDealer dealer = CardDealer.getInstance();
        int h = loot.getNHangars();
        
        if (h > 0){
            hangar = dealer.nextHangar();
            receiveHangar(hangar);
        }
        
        int elements = loot.getNSupplies();
        
        for (int i=0; i<elements; i++){
            SuppliesPackage sup = dealer.nextSuppliesPackage();
            receiveSupplies(sup);
        }
        
        elements = loot.getNWeapons();
        
        for (int i=0; i<elements; i++){
            Weapon weap = dealer.nextWeapon();
            receiveWeapon(weap);
        }
        
        elements = loot.getNShields();
        
        for (int i=0; i<elements; i++){
            ShieldBooster sh = dealer.nextShieldBooster();
            receiveShieldBooster(sh);
        }
        
        int medals = loot.getNMedals();
        
        nMedals += medals;
        
        if (loot.getSpaceCity())
            return Transformation.SPACECITY; //sintaxis??
        else if (loot.getEfficient())
            return Transformation.GETEFFICIENT;
        else
            return Transformation.NOTRANSFORM;
    }

    public void setPendingDamage (Damage d){
        pendingDamage = d.adjust(weapons, shieldBoosters);
    }

    public boolean validState (){
        if (pendingDamage == null || pendingDamage.hasNoEffect())
            return true;
        else
            return false;
    }
}
