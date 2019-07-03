#encoding:utf-8

module Deepspace
  module WeaponType
    class Type
      attr_reader :power

      def initialize (power)
        @power=power
      end

      def to_s
        if @power == 2.0 then
          return "LASER"
        elsif @power == 3.0 then
          return "MISSILE"
        else
          return "PLASMA"
        end
      end
    end

    LASER = Type.new(2.0)
    MISSILE = Type.new(3.0)
    PLASMA = Type.new(4.0)
  end
end
