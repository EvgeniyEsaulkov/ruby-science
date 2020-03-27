class Box < ApplicationRecord
  belongs_to :carwash
  has_many :tickets

  scope :with_tickets, ->(date) { joins(:tickets).where(tickets: { ticket_date: date }).uniq }
  scope :visible, -> { where(visible_in_search_results: true) }

  def self.for_date(date = nil)
    with_tickets(date).each_with_object({}) do |box, hsh|
      hsh[box] = box.tickets.for_date(date)
    end
  end

  def self.visible_for_date(date = nil)
    visible.for_date(date)
  end
end
