class ReviewsController < ApplicationController
  def index
  end

  def new
    @review = Review.new
  end

  def emergency
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to :action => "http://localhost:3000"
    end
  end

end
