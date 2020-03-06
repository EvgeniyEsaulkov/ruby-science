class FindBooks
  include Interactor

  def call
    context.books = case context.field
      when 'author' then Book.found_by_author(context.term)
      when 'title' then Book.found_by_title(context.term)
      when 'number' then Book.found_by_number(context.term)
      else Book.found(context.term)
    end
  end
end
