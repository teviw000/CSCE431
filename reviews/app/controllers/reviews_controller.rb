require File.dirname(__FILE__) + '/yelpAPI'
require 'json'

class ReviewsController < ApplicationController
  protect_from_forgery with: :null_session

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


  def leave_review
    @review = params[:param_review]
    @rating = params[:param_rating]
    @price = params[:param_price]
    @safety = params[:param_safety]
    @service = params[:param_service]
    @cash = params[:param_cash]
    @english = params[:param_english]
    @tips = params[:param_tips]
    @wifi = params[:param_wifi]
    @wheelchair = params[:param_wheelchair]
    @submit = params[:param_submit]
    # block comment: ctrl-k-c, uncomment: ctrol-k-u
  end

  def show
    @yelp_review_id = params[:id]
    @yelp_review_info = business(@yelp_review_id)
    #To see typing of @yelp_review_info, see https://www.yelp.com/developers/documentation/v3/business
  end

  def emergency
  end

  def yelp_help(food, city)
    search(food, city)
  end

  def create
    


    @review = review.new(params) #something like this

    redirect_to reviews_path
  end

end
