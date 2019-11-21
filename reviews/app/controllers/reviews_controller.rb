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
    #@reviews = Reviews.new
    @reviews = "" #temporary fix so that app will run
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
    puts "******************************"
    puts params[:param_text]
    puts params[:param_cash]
    puts params[:param_english]
    puts params[:param_tips]
    puts params[:param_wifi]
    puts params[:param_wheelchair]
    puts params[:param_rating]
    puts params[:param_price]
    puts params[:param_safety]
    puts params[:param_service]
    puts "******************************"
    #render plain: params[:my_data].inspect #display on website in plaintext
    
    @reviews = Reviews.new(params[:param_text])
    # respond_to do |format|
    #   if @reviews.save
    #     format.html { redirect_to @reviews, notice: 'Review was successfully created.' }
    #     format.json { render json: @reviews, status: :created, location: @reviews }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @reviews.errors, status: :unprocessable_entity }
    #   end
    # end

    redirect_to reviews_path
  end

end
