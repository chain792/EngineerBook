class BooksController < ApplicationController
  def index

  end
  def search
    if params[:search]
      url = "https://www.googleapis.com/books/v1/volumes"
      text = params[:search]
      res = Faraday.get(url, q: text, maxResults: 30)
      @books = JSON.parse(res.body)
    end
  end
end
