class BooksController < ApplicationController
  before_action :set_volume_info, only: %i[create]

  def index
    @books = Book.all.includes(:authors,:user).order(created_at: :desc)
  end

  def new
    @book = Book.new
    @volume_info = params[:volumeInfo]
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save_with_author(authors_params[:authors])
      redirect_to books_path, success: t('defaults.message.created', item: t('defaults.review'))
    else
      flash.now[:danger] = t('defaults.message.not_created', item: t('defaults.review'))
      render 'new'
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit

  end

  def update

  end

  def destroy
    @book = current_user.books.find(params[:id])
    @book.destroy!
    redirect_to books_path, success: t('defaults.message.deleted', item: t('defaults.review'))
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
    @volume_info[:bookImage] = params[:book][:remote_book_image_url]
    @volume_info[:infoLink] = params[:book][:info_link]
    @volume_info[:publishedDate] = params[:book][:published_date]
  end
end
