class Entity
  attr_accessor :who, :type, :amount

  def initialize(who:, type:, amount:)
    @who = who
    @type = type
    @amount = amount
  end
end
