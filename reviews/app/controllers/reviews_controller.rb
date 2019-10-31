class ReviewsController < ApplicationController
  def index
  end

  def new
    @review = Review.new
  end

  def emergency
  end

  def create
    #I don't think this will work until a seperate .rb file and/or class is created?
    #https://stackoverflow.com/questions/35496179/uninitialized-constant-userscontrollercategories
    @category = Category.new(category_params = "")

    if @category.save
      redirect_to :action => "http://localhost:3000"
    end
  end

end
