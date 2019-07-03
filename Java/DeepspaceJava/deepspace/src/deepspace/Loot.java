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
public class Loot {
    private int nSupplies;
    private int nWeapons;
    private int nShields;
    private int nHangars;
    private int nMedals;
    private boolean efficient;
    private boolean spaceCity;

    Loot (int supplies, int weapons, int shields, int hangars, int medals){
        nSupplies = supplies;
        nWeapons = weapons;
        nShields = shields;
        nHangars = hangars;
        nMedals = medals;
        efficient = false;
        spaceCity = false;
    }
    
    Loot (int supplies, int weapons, int shields, int hangars, int medals, boolean ef, boolean city){
        nSupplies = supplies;
        nWeapons = weapons;
        nShields = shields;
        nHangars = hangars;
        nMedals = medals;
        efficient = ef;
        spaceCity = city;
    }

    public int getNSupplies (){
        return nSupplies;
    }

    public int getNWeapons (){
        return nWeapons;
    }

    public int getNShields (){
        return nShields;
    }

    public int getNHangars (){
        return nHangars;
    }

    public int getNMedals (){
        return nMedals;
    }
    
    public boolean getEfficient (){
        return efficient;
    }
    
    public boolean getSpaceCity (){
        return spaceCity;
    }
    
    public LootToUI getUIversion (){
      return new LootToUI(this);
    }
    
    @Override
    public String toString(){
        String mensaje = "Hangares: "+this.getNHangars()+
                "\narmas: "+this.getNWeapons()+
                "\nescudos: "+this.getNShields()+
                "\nmedallas: "+this.getNMedals();
        return mensaje;
    }
}
