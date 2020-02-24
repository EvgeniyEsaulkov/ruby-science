class Box < ApplicationRecord
  belongs_to :carwash
  has_many :tickets

  scope :with_tickets, ->(date) { joins(:tickets).where(tickets: { ticket_date: date }).uniq }
  scope :visible, -> { where(visible_in_search_results: true) }
end
