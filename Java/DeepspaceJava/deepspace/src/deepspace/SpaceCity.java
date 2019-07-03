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
public class SpaceCity extends SpaceStation{
    private ArrayList<SpaceStation> collaborators = new ArrayList<>();
    private SpaceStation base;
    
    SpaceCity (SpaceStation bas, ArrayList<SpaceStation> rest){
        super(bas);
        
        base = bas;
        collaborators = rest;
    }
    
    public ArrayList<SpaceStation> getCollaborators (){
        return collaborators;
    }
    
    @Override
    public float fire (){
        int suma = 0;
        
        for (int i=0; i<collaborators.size(); i++)
            suma += collaborators.get(i).fire();
        
        return suma + super.fire();
    }
    
    @Override
    public SpaceCityToUI getUIversion (){
        return new SpaceCityToUI(this);
    }
    
    @Override
    public float protection (){
        int suma = 0;
        
        for (int i=0; i<collaborators.size(); i++)
            suma += collaborators.get(i).protection();
        
        return suma + super.protection();
    }
    
    @Override
    public Transformation setLoot (Loot loot){
        super.setLoot(loot);
        
        return Transformation.NOTRANSFORM;
    }
    
}
