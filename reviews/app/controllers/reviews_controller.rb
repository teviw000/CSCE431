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

<<<<<<< HEAD
  def yelp_help
    search('tacos', 'College Station')
  end
=======
  def create
    #I don't think this will work until a seperate .rb file and/or class is created?
    #https://stackoverflow.com/questions/35496179/uninitialized-constant-userscontrollercategories
    @category = Category.new(category_params = "")

    if @category.save
      redirect_to :action => "\"
    end
  end

>>>>>>> c61cdf9364a1c33a8789f1b552f51af6fcd9f079
end
