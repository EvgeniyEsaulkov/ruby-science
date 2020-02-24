class CarwashDecorator < SimpleDelegator
  def pretty_title
    "&laquo;#{title}&raquo; #{address}".html_safe
  end

  def url_string
    return '' if url.blank?
    url.gsub('http://', '').gsub('www.', '')
  end

  def start_time_string
    start_time.strftime('%H:%M')
  end

  def end_time_string
    end_time.strftime('%H:%M')
  end
end
