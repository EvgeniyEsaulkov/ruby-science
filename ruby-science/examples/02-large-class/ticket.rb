class Ticket < ApplicationRecord
  belongs_to :box

  scope :new_status, -> { where(status: Ticket::NEW).order('date desc, start_time asc') }
  scope :open,       -> { where(status: Ticket::OPEN).order('date desc, start_time asc') }
end
