class TicketsPresenter
  attr_reader :tickets

  def initialize(tickets)
    @tickets = tickets
  end

  def total_sum
    tickets.sum(&:total_cost_with_bonus)
  end
end
