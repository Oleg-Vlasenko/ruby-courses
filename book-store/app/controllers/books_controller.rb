class BooksController < ApplicationController
  def index
    @book = Book.find_by_id(params[:id]) or not_found
  end
end
