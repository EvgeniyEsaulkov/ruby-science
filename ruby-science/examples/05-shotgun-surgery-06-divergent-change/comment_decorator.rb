class CommentDecorator < ApplicationDecorator
  delegate :body

  def date(format:)
    DateTime.new(object.year.to_i, object.month.to_i, object.day.to_i).to_s(format)
  end
end
