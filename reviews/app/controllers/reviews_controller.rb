require File.dirname(__FILE__) + '/yelpAPI'

class ReviewsController < ApplicationController
  def index
    @reviews = Review.search(params[:search])
  end

  def new
    @review = Review.new
  end

  def emergency
  end

  def yelp_help
    search('tacos', 'College Station')
  end
  def create
    #I don't think this will work until a seperate .rb file and/or class is created?
    #https://stackoverflow.com/questions/35496179/uninitialized-constant-userscontrollercategories
    @category = Category.new(category_params = "")

    if @category.save
      redirect_to :action => "\"
    end
  end

end
