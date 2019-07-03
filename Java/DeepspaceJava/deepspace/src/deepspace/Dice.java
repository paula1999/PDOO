/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.Random;

/**
 *
 * @author paula
 */
public class Dice {
    private float NHANGARSPROB;
    private float NSHIELDSPROB;
    private float NWEAPONSPROB;
    private float FIRSTSHOTPROB;
    private float EXTRAEFFICIENCY;
    private Random generator;

    Dice (){
        NHANGARSPROB = 0.25f;
        NSHIELDSPROB = 0.25f;
        NWEAPONSPROB = 0.33f;
        FIRSTSHOTPROB = 0.5f;
        EXTRAEFFICIENCY = 0.8f;
        generator = new Random();
    }
    
    public boolean extraEfficiency (){
        float r = generator.nextFloat();
        
        return r < EXTRAEFFICIENCY;
    }

    public int initWithNHangars (){
        float prob = generator.nextFloat();

        if (prob < NHANGARSPROB){
            return 0;
        }
        else{
            return 1;
        }
    }

    public int initWithNWeapons (){
        float prob = generator.nextFloat();

        if (prob < NWEAPONSPROB){
            return 1;
        }
        else if (prob < 2*NWEAPONSPROB){
            return 2;
        }
        else{
            return 3;
        }
    }

    public int initWithNShields (){
        float prob = generator.nextFloat();

        if (prob < NSHIELDSPROB){
            return 0;
        }
        else{
            return 1;
        }
    }

    public int whoStarts (int nPlayers){
        int player = generator.nextInt(nPlayers);

        return player;
    }

    public GameCharacter firstShot (){
        float prob = generator.nextFloat();

        if (prob <= FIRSTSHOTPROB){
            return GameCharacter.SPACESTATION;
        }
        else{
            return GameCharacter.ENEMYSTARSHIP;
        }
    }

    boolean spaceStationMoves (float speed){
        float prob = generator.nextFloat();

        if (prob <= speed){
            return true;
        }
        else{
            return false;
        }
    }
    
    @Override
    public String toString(){
        String mensaje = "Numero de hangares inicial: "+this.initWithNHangars()+
                ", numero de armas inicial: "+this.initWithNWeapons()+
                ", numero de escudos inicial: "+this.initWithNShields()+
                ", y dispara primero "+this.firstShot();
        return mensaje;
    }
}
