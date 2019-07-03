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
public class GameUniverse {
    private static int WIN = 10;
    private int turns;
    private int currentStationIndex;
    private Dice dice;
    private GameStateController gameState;
    private boolean haveSpaceCity;
    private ArrayList<SpaceStation> spaceStations;
    private SpaceStation currentStation;
    private EnemyStarShip currentEnemy;
    
    
    public GameUniverse (){
      turns = 0;
      gameState = new GameStateController();
      currentStationIndex = -1;
      dice = new Dice();
      currentStation = null;
      spaceStations = new ArrayList<>();
      currentEnemy = null;
      haveSpaceCity = false;
    }

    public CombatResult combat (SpaceStation station, EnemyStarShip enemy){
        GameCharacter ch = dice.firstShot();
        boolean enemyWins;
        float fire;
        ShotResult result;
        CombatResult combatResult;

        if (ch == GameCharacter.ENEMYSTARSHIP){
            fire = enemy.fire();
            result = station.receiveShot(fire);

            if (result == ShotResult.RESIST){
                fire = station.fire();
                result = enemy.receiveShot(fire);
                enemyWins = (result == ShotResult.RESIST);
            }
            else
                enemyWins = true;
        }
        else{
            fire = station.fire();
            result = enemy.receiveShot(fire);
            enemyWins = (result==ShotResult.RESIST);
        }

        if (enemyWins){
            float s = station.getSpeed();
            boolean moves = dice.spaceStationMoves(s);

            if (!moves){
                Damage damage = enemy.getDamage();
                station.setPendingDamage(damage);
                combatResult = CombatResult.ENEMYWINS;
            }
            else{
                station.move();
                combatResult = CombatResult.STATIONESCAPES;
            }
        }
        else{
            Loot aLoot = enemy.getLoot();
            Transformation transf = station.setLoot(aLoot);
            combatResult = CombatResult.STATIONWINSANDCONVERTS;
            
            if (transf == Transformation.GETEFFICIENT)
                makeStationEfficient();
            else if (transf == Transformation.SPACECITY && !haveSpaceCity)
                createSpaceCity();
            else
                combatResult = CombatResult.STATIONWINS;
        }

        gameState.next(turns, spaceStations.size());

        return combatResult;
    }
    
    public CombatResult combat (){
        if ((getState() == GameState.BEFORECOMBAT) || (getState() == GameState.INIT))
            return combat(currentStation, currentEnemy);
        else
            return CombatResult.NOCOMBAT;
    }
    
    private void createSpaceCity (){
        ArrayList<SpaceStation> rest = new ArrayList<>();
            
        for (int i=0; i<spaceStations.size(); i++)
            if (spaceStations.get(i) != currentStation)
                rest.add(spaceStations.get(i));
            
        currentStation = new SpaceCity(currentStation, rest);
        spaceStations.set(currentStationIndex, currentStation);
        haveSpaceCity = true; 
    }
    
    public void discardHangar (){
        if (currentStation != null)
            currentStation.discardHangar();  
    }

    public void discardShieldBooster (int i){
        if (gameState.getState() == GameState.INIT || gameState.getState() == GameState.AFTERCOMBAT)
            currentStation.discardShieldBooster(i); 
    }

    public void discardShieldBoosterInHangar(int i){
        if (gameState.getState() == GameState.INIT || gameState.getState() == GameState.AFTERCOMBAT)
            currentStation.discardShieldBoosterInHangar(i);
    }

    public void discardWeapon (int i){
        if (gameState.getState() == GameState.INIT || gameState.getState() == GameState.AFTERCOMBAT)
            currentStation.discardWeapon(i);
    }

    public void discardWeaponInHangar (int i){
        if (gameState.getState() == GameState.INIT || gameState.getState() == GameState.AFTERCOMBAT)
            currentStation.discardWeaponInHangar(i);
    }

    public GameState getState (){
      return gameState.getState();
    }

    public GameUniverseToUI getUIversion (){
      return new GameUniverseToUI(currentStation, currentEnemy);
    }

    public boolean haveAWinner (){
        if (currentStation != null)
            return (currentStation.getNMedals() >= WIN);
        else
            return false;
    }

    public void init (ArrayList<String> names){
        if (getState() == GameState.CANNOTPLAY){
            CardDealer dealer = CardDealer.getInstance();

            for (int i=0; i< names.size(); i++){
                SuppliesPackage supplies = dealer.nextSuppliesPackage();
                SpaceStation station = new SpaceStation(names.get(i), supplies);
                spaceStations.add(station);
                int nh = dice.initWithNHangars();
                int nw = dice.initWithNWeapons();
                int ns = dice.initWithNShields();
                Loot lo = new Loot(0, nw, ns, nh, 0);
                station.setLoot(lo);
            }

            currentStationIndex = dice.whoStarts(names.size());
            currentStation = spaceStations.get(currentStationIndex);
            currentEnemy = dealer.nextEnemy();
            gameState.next(turns, spaceStations.size());
        }
    }
    
    private void makeStationEfficient (){
        if (dice.extraEfficiency())
            currentStation = new BetaPowerEfficientSpaceStation(currentStation);
        else
            currentStation = new PowerEfficientSpaceStation(currentStation);
        
        spaceStations.set(currentStationIndex, currentStation);
    }

    public void mountShieldBooster (int i){
        if (gameState.getState() == GameState.INIT || gameState.getState() == GameState.AFTERCOMBAT)
            currentStation.mountShieldBooster(i);
    }

    public void mountWeapon (int i){
        if (gameState.getState() == GameState.INIT || gameState.getState() == GameState.AFTERCOMBAT)
            currentStation.mountWeapon(i);  
    }

    public boolean nextTurn (){
        if (getState() == GameState.AFTERCOMBAT){
            boolean stationState = currentStation.validState();
            
            if (stationState){
                currentStationIndex = (currentStationIndex + 1) % spaceStations.size();
                turns += 1;
                currentStation = spaceStations.get(currentStationIndex);
                currentStation.cleanUpMountedItems();
                CardDealer dealer = CardDealer.getInstance();
                currentEnemy = dealer.nextEnemy();
                gameState.next(turns, spaceStations.size());
                
                return true;
            }
            
            return false;
        }
        
        return false;
    }
}
