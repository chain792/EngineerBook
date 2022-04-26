class BooksController < ApplicationController
  def search
    @books = RakutenWebService::Books::Book.search(title: "良いコード／悪いコードで学ぶ設計入門")
  end
end
