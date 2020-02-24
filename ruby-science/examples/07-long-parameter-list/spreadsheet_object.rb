class SpreadsheetObject
  DEFAULT_FORMAT_PARAMS = { size: 10 }.freeze

  TABLE_FORMAT_PARAMS = DEFAULT_FORMAT_PARAMS.merge(
    text_wrap: true,
    border: :thin,
    vertical_align: :top
  ).freeze

  HEADER_FORMAT_PARAMS = TABLE_FORMAT_PARAMS.merge(
    weight: :bold,
    horizontal_align: :center,
    vertical_align: :center
  ).freeze

  TABLE_GREY_FORMAT_PARAMS = TABLE_FORMAT_PARAMS.merge(
    pattern_bg_color: :silver,
    pattern_fg_color: :silver,
    pattern: 1
  ).freeze

  def initialize(sheet, current_row = 0)
    @sheet = sheet
    @current_row = current_row
  end

  def push_table(table, current_row = nil)
    @current_row = current_row if current_row

    format_columns(table.widths)
    add_headers(table.headers)
    add_table_rows(table.items)
  end

private

  attr_reader :sheet
  attr_accessor :current_row

  def format_columns(widths)
    format = Spreadsheet::Format.new(DEFAULT_FORMAT_PARAMS)

    widths.each_with_index do |width, index|
      sheet.format_column(index, format, { :width => width/5.55 })
    end
  end

  def add_headers(data)
    format = Spreadsheet::Format.new(HEADER_FORMAT_PARAMS)

    data.each_with_index do |header, index|
      sheet.row(current_row).push(header)
      sheet.row(current_row).set_format(index, format)
    end

    current_row += 1
  end

  def add_table_rows(items)
    items.each do |values|
      values.each_with_index do |value, index|
        sheet.row(current_row).push(value.to_s.gsub("\r\n", "\n"))
        sheet.row(current_row).set_format(index, next_row_format)
      end

      current_row += 1
    end

    current_row
  end

  def table_formats
    @table_formats ||= [
      Spreadsheet::Format.new(TABLE_FORMAT_PARAMS),
      Spreadsheet::Format.new(TABLE_GREY_FORMAT_PARAMS)
    ]
  end

  def next_row_format
    table_formats[(current_row + 1).divmod(2)[1]]
  end
end
