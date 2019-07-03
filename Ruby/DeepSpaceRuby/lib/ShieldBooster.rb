#encoding:utf-8

require_relative 'ShieldToUI'

module Deepspace
  class ShieldBooster
    attr_reader :name, :boost, :uses

    def initialize(name, boost, uses)
      @name = name
      @boost = boost
      @uses = uses
    end

    def self.newCopy(s)
      new(s.name, s.boost, s.uses)
    end

    public
    def useIt
      if @uses > 0 then
        @uses = @uses-1
        return @boost
      else
        return 1.0
      end
    end

    def to_s
      return "name: #{@name}, boost: #{@boost}, uses: #{@uses}"
    end

    def getUIversion
      return ShieldToUI.new(self)
    end
  end
end
