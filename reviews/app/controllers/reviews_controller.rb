class ReviewsController < ApplicationController
  def index
    @reviews = Review.search(params[:search])
  end

  def new
  end

  def emergency
  end
end
