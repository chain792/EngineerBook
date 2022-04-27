class BooksController < ApplicationController
  def search
    url = "https://www.googleapis.com/books/v1/volumes"
    text='プログラミング'
    res = Faraday.get(url, q: text)
    @books = JSON.parse(res.body)
  end
end
