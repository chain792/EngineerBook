class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    category_ids = Category.find(params[:id]).subtree_ids
    @books = Book.where(category_id: category_ids).includes(:authors, :user, :category).order(created_at: :desc)
    render 'books/index'
  end
end
