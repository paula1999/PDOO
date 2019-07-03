#encoding:utf-8

require '../lib/CombatResult.rb'
require '../lib/Dice.rb'
require '../lib/GameCharacter.rb'
require '../lib/Loot.rb'
require '../lib/ShieldBooster.rb'
require '../lib/ShotResult.rb'
require '../lib/SuppliesPackage.rb'
require '../lib/Weapon.rb'
require '../lib/WeaponType.rb'

module Pruebas

  class TestP1

    def initialize

    end

    def self.main

      # Loot:
      i = 0

      while i < 3
        botin = Deepspace::Loot.new(i, i, i, i, i)

        print "\nBotin ",i+1
        print "\n  Numero de suministros: ", botin.nSupplies
        print "\n  Numero de armas: ", botin.nWeapons
        print "\n  Numero de escudos: ", botin.nShields
        print "\n  Numero de hangares: ", botin.nHangars
        print "\n  Numero de medallas: ", botin.nMedals

        i += 1
      end

      print "\n"

      # Supplies
      i = 0

      while i < 3
        supplies = Deepspace::SuppliesPackage.new(i, i, i)

        print "\nSuministro ", i+1
        print "\n Armamento: ", supplies.ammoPower
        print "\n Combustible: ", supplies.fuelUnits
        print "\n Energia para los escudos: ", supplies.shieldPower

        i += 1
      end

      # ShieldBooster
      i = 0

      while i < 3
        sBooster = Deepspace::ShieldBooster.new("Escudo", i, i)

        print "\nShield Booster ", i+1
        print "\n ", sBooster.name
        print "\n Boost: ", sBooster.boost
        print "\n Usos: ", sBooster.uses

        i += 1
      end

      # Weapon

      arma1 = Deepspace::Weapon.new("laser", Deepspace::WeaponType::LASER, 1)
      arma2 = Deepspace::Weapon.new("misil", Deepspace::WeaponType::MISSILE, 2)
      arma3 = Deepspace::Weapon.new("plasma", Deepspace::WeaponType::PLASMA, 0)

      puts "\n \nArma 1:"

      if arma1.type == Deepspace::WeaponType::LASER then
        print "\nTipo: laser"
      elsif arma1.type == Deepspace::WeaponType::MISSILE then
        print "\nTipo: misil"
      elsif arma1.type == Deepspace::WeaponType::PLASMA then
        print "\nTipo: plasma"
      end

      print "\n Usos: ", arma1.uses
      print "\n Potencia: ", arma1.power
      print "\n Metodo useIt: "
      print "\n ", arma1.useIt
      print "\n ", arma1.useIt

      puts "\n \nArma 2:"

      if arma2.type == Deepspace::WeaponType::LASER then
        print "\nTipo: laser"
      elsif arma2.type == Deepspace::WeaponType::MISSILE then
        print "\nTipo: misil"
      elsif arma2.type == Deepspace::WeaponType::PLASMA then
        print "\nTipo: plasma"
      end

      print "\n Usos: ", arma2.uses
      print "\n Potencia: ", arma2.power
      print "\n Metodo useIt: "
      print "\n ", arma2.useIt
      print "\n ", arma2.useIt

      puts "\n \nArma 3:"

      if arma3.type == Deepspace::WeaponType::LASER then
        print "\nTipo: laser"
      elsif arma3.type == Deepspace::WeaponType::MISSILE then
        print "\nTipo: misil"
      elsif arma3.type == Deepspace::WeaponType::PLASMA then
        print "\nTipo: plasma"
      end

      print "\n Usos: ", arma3.uses
      print "\n Potencia: ", arma3.power
      print "\n Metodo useIt: "
      print "\n ", arma3.useIt
      print "\n ", arma3.useIt
    end

  end

end

Pruebas::TestP1.main
