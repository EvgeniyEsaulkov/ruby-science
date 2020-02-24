# coding: utf-8

class Carwash < ActiveRecord::Base
  validates :title, :slug, :address, :start_time, :end_time, :presence => true

  mount_uploader :logo, LogoUploader

  belongs_to :area
  belongs_to :city
  belongs_to :owner, :class_name => 'User'
  has_many :users
  has_many :clients
  has_many :boxes
  has_many :price_groups
  has_many :services
  has_many :photos
  has_many :tickets, through: :boxes

  default_scope where(locked: false, enabled: true)

  def boxes_with_tickets_for_date(date = nil)
    boxes.with_tickets(date).each_with_object({}) do |box, hsh|
      hsh[box] = box.tickets.for_date(date)
    end
  end

  def visible_boxes_with_tickets_for_date(date = nil)
    boxes.visible.with_tickets(date).each_with_object({}) do |box, hsh|
      hsh[box] = box.tickets.for_date(date)
    end
  end

  def timeline(date, time, opts = {})
    CarwashTimeline.new(self, date, time, opts)
  end

  def start_time_string=(start_time_string)
    self.start_time = Time.zone.parse(start_time_string)
  end

  def end_time_string=(end_time_string)
    self.end_time = Time.zone.parse(end_time_string)
  end

  def all_day_long?
    true if self.start_time.strftime('%H:%M') == "00:00" && self.end_time.in_minutes > 1400
  end

  def open_at_time?(s_time)
    res = s_time.in_minutes > self.end_time.in_minutes || s_time.in_minutes < self.start_time.in_minutes ? false : true
  end
end
