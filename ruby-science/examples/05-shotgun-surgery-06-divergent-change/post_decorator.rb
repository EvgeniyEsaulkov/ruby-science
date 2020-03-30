class PostDecorator < ApplicationDecorator
  delegate :title, :body

  decorates_association :comments

  def date(format:)
    DateTime.new(object.year.to_i, object.month.to_i, object.day.to_i).to_s(format)
  end

  def comments_are_present?
    object.comments.present?
  end
end
