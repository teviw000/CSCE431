require File.dirname(__FILE__) + '/yelpAPI'
require 'json'

class ReviewsController < ApplicationController
  def index
    # Make sure both parameters are present
    if !params[:near].blank? and !params[:find].blank?
      @near = params[:near]
      @find = params[:find]
      # Query yelp to get @find related businesses @near a location
      @results = yelp_help(@find, @near)["businesses"]
      #To see typing of @results, see https://www.yelp.com/developers/documentation/v3/business_search
    else 
      @results = []
    end
  end


  def new
    @review = ""
    @rating = 5
  end

  def show
    @yelp_review_id = params[:id]
    @yelp_review_info = business(@yelp_review_id)
    #To see typing of @yelp_review_info, see https://www.yelp.com/developers/documentation/v3/business
    
    #holds data for show.html
    #works for regular strings and ints, but not objects like location so far
    array = [ @yelp_review_info["location.city"] ]
    @print = array.map { |i| "Testing: #{i}" }
  end

  def emergency
  end

  def yelp_help(food, city)
    search(food, city)
  end

  def create
    #I don't think this will work until a seperate .rb file and/or class is created?
    #https://stackoverflow.com/questions/35496179/uninitialized-constant-userscontrollercategories
    #@category = Category.new(category_params = "")

    if @category.save
      redirect_to :action => "/"
    end
  end

end
