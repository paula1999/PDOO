require_relative '../lib/Dice'
require_relative '../lib/SpecificDamage'
require_relative '../lib/CardDealer'

module Test_P4
  class Test_p4
    def self.main
      dice = Deepspace::Dice.new

      puts dice.extraEfficiency

      weapon_types = [Deepspace::WeaponType::PLASMA, Deepspace::WeaponType::LASER, Deepspace::WeaponType::MISSILE]
      sDamage = Deepspace::SpecificDamage.new(weapon_types, 5)
      #d2 = Deepspace::SpecificDamage.newCopy(sDamage)

      puts sDamage
      #puts d2

      dealer = Deepspace::CardDealer.instance
      w = dealer.nextWeapon
      #d2.discardWeapon(w)

      #Los cambios realizados a d2 no afectan a d1
      puts sDamage
      #puts d2
      puts sDamage.getUIversion
    end
  end

  Test_p4.main

end
