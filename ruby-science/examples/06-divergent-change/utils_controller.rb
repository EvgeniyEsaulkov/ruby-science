class UtilsController
   def search
    result = FindBooks.call(field: params[:field], term: params[:q])
    @books = result.success? ? result.books : []

    respond_to do |format|
      format.html { render 'shared/_books' }
      format.csv { render 'shared/_books' }
      format.xls { export_books_to_xls(@books) }
    end
  end
end
