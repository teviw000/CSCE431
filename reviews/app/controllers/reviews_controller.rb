class ReviewsController < ApplicationController
  def index
  end

  def new
  end

  def emergency
  end

  def review_page
    @review = review.new
  end

end
