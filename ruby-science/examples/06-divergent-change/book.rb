class Book < ApplicationRecord
  scope :found_by_author, -> (term) { where(author: term) }
  scope :found_by_title,  -> (term) { where(title: term) }
  scope :found_by_number, -> (term) { where(number: term) }

  def self.found(term)
    found_by_author(term) + found_by_title(term) + found_by_number(term)
  end
end
