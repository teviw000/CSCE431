require 'reviews_helper'
include ReviewsHelper
require 'json'

class ReviewsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    # Make sure both parameters are present
    #puts params
    if !params[:near].blank? and !params[:find].blank?
      
      @near = params[:near]
      @find = params[:find]
      if @near === "Current Location"
        @latitude = params[:lat]
        @longitude = params[:long]
        @results = yelp_help_location(@find, @latitude, @longitude)["businesses"]
      else
        # Query yelp to get @find related businesses @near a location
        @results = yelp_help(@find, @near)["businesses"]
        #To see typing of @results, see https://www.yelp.com/developers/documentation/v3/business_search
      end
    else 
      @results = []
    end
  end


  def leave_review
    #@reviews = Reviews.new
    #@reviews = "" #temporary fix so that app will run
    @review = Review.new
    @review["business_id"] = params[:id]
    @review["user_email"] = "ryan@example.com"
    puts @review
    puts @review["business_id"]
    puts @review["rating"]
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

  def yelp_help_location(food, lat, long)
    search_location(food, lat, long)
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
    #create params hash to have all parameters in a single parameter
    #validates_presence_of :business_id, :user_email, :comment, :rating, :price, :safety, :service, :cash_only, :english, :tips, :wifi, :wheelchair
    review_parameters = {
      :business_id => params[:id],
      :user_email => "zach@example.com",
      :comment => params[:param_text],
      :rating => params[:param_rating].to_i,
      :price => params[:param_price].to_i,
      :safety => params[:param_safety].to_i,
      :service => params[:param_service].to_i,
      :cash_only => params[:param_cash]["result"] == "0" ? false : true,
      :english => params[:param_english]["result"] == "0" ? false : true,
      :tips => params[:param_tips]["result"] == "0" ? false : true,
      :wifi => params[:param_wifi]["result"] == "0" ? false : true,
      :wheelchair => params[:param_wheelchair]["result"] == "0" ? false : true
    }
    puts review_parameters
    @reviews = Review.new(review_parameters)
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
