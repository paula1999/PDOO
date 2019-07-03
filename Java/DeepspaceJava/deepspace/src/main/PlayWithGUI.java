/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import controller.Controller;
import deepspace.GameUniverse;
import View.GUI.MainWindow;
import View.*;

/**
 *
 * @author paula
 */
public class PlayWithGUI {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        GameUniverse gameUniverse = new GameUniverse();
        DeepSpaceView deepSpaceView = MainWindow.getInstance();
        Controller controller = Controller.getInstance();
        controller.setModelView(gameUniverse, deepSpaceView);
        controller.start();
    }
}
