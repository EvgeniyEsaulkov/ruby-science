class UtilsController
   def search
    @books = FindBooks.call(field: params[:field], term: params[:q])

    respond_to do |format|
      format.html { render 'shared/_books' }
      format.csv { render 'shared/_books' }
      format.xls { export_books_to_xls(@books) }
    end
  end
end
