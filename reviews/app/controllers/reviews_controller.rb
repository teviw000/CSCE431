class ReviewsController < ApplicationController
  def index
  end

  def new
    @review = Review.new
  end

  def emergency
  end

  def create
    redirect_to :back
  end

end
