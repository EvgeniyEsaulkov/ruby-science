class SpreadsheetTable
  def initialize(headers, items, widths)
    @headers = headers
    @items = items
    @widths = widths
  end

  attr_reader :headers, :items, :widths
end
