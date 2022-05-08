class BooksController < ApplicationController
  before_action :set_volume_info, only: %i[create]

  def index
    @books = Book.all.includes(:authors,:user).order(created_at: :desc)
  end

  def new
    @book = Book.new
    @volume_info = params[:volumeInfo]
    @volume_info[:book_image] = params.dig(:volumeInfo, :imageLinks, :thumbnail)
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save_with_author(author_params[:authors])
      redirect_to books_path, success: t('defaults.message.created', item: 'レビュー')
    else
      flash.now[:danger] = t('defaults.message.not_created', item: 'レビュー')
      render 'new'
    end
  end

  def search
    if params[:search]
      url = "https://www.googleapis.com/books/v1/volumes"
      text = params[:search]
      res = Faraday.get(url, q: text, maxResults: 30)
      @google_books = JSON.parse(res.body)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :remote_book_image_url, :info_link, :published_date)
  end

  def authors_params
    params.require(:book).permit(authors: [])
  end

  def set_volume_info
    @volume_info = {}
    @volume_info[:title] = params[:book][:title]
    @volume_info[:authors] = params[:book][:authors]
    @volume_info[:book_image] = params[:book][:remote_book_image_url]
    @volume_info[:infoLink] = params[:book][:info_link]
    @volume_info[:publishedDate] = params[:book][:published_date]
  end
end
