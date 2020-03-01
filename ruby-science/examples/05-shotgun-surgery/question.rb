# app/models/consultation.rb
class Consultation < ActiveRecord::Base
  attr_accessible :content

  delegate :author_name, :author_email, to: :author
end

class Question < ActiveRecord::Base
  attr_accessible :content

  delegate :author_name, :author_email, to: :author
end

class Author < ActiveRecord::Base
  def author_name
    name.presence || "Аноним"
  end
end
