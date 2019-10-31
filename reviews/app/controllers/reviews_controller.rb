class ReviewsController < ApplicationController
  def index
  end

  def new
    @review = Review.new
  end

  def emergency
  end

  def create
    redirect_back(fallback_location: fallback_location)
  end

end
