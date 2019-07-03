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
public class ShieldBooster {
    private String name;
    private float boost;
    private int uses;

    ShieldBooster (String n, float b, int u){
        name = n;
        boost = b;
        uses = u;
    }

    ShieldBooster (ShieldBooster s){
        name = s.getName();
        boost = s.getBoost();
        uses = s.getUses();
    }

    public String getName (){
        return name;
    }

    public float getBoost (){
        return boost;
    }

    public int getUses (){
        return uses;
    } 

    public float useIt (){
        if (uses > 0){
            uses--;
            return boost;
        }
        else
            return 1.0f;
    }
    
    public ShieldToUI getUIversion (){
        return new ShieldToUI(this);
    }
    
    @Override
    public String toString(){
        return "Nombre: "+this.name+" \nPotencia: "+this.getBoost()+" \nUsos: "+this.getUses()+"  ";
    }
}
