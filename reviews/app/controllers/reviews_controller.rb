require 'reviews_helper'
include ReviewsHelper
require 'json'

class ReviewsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    # Make sure both parameters are present
    if !params[:near].blank? and !params[:find].blank?
      @near = params[:near]
      @find = params[:find]
      if @near === "Current Location"
        @latitude = params[:lat]
        @longitude = params[:long]
        @results = yelp_help_location(@find, @latitude, @longitude)
      else
        # Query yelp to get @find related businesses @near a location
        @results = yelp_help(@find, @near)
        #To see typing of @results, see https://www.yelp.com/developers/documentation/v3/business_search
      end
      

      @display_results = get_display_results(@results)

      if !params[:sort_by].blank?
        if param[:sort_by] == 'highest rated first'
          @display_results = get_high_rate_first(@display_results)
        end
      end

      @display_results = get_correct_order(@display_results)
    else 
      @display_results = []
    end
  end


  def leave_review
    @review = Review.new
  end
  

  def show
    @yelp_review_id = params[:id]
    #To see typing of @yelp_review_info, see https://www.yelp.com/developers/documentation/v3/business
    @yelp_review_info = business(@yelp_review_id)
    #@user_reviews is an array of type Review. See the types in reviews/db/schema.rb 
    @user_reviews = Review.where(business_id: params[:id])
    # FOR VIWAT <3: @avg_user_rating = @user_reviews.map{ |review| review["rating"]}.reduce(:+).to_f / @user_reviews.size
  end

  def emergency
  end

  def review_params 
    allow = [:business_id, :user_email, :comment, :rating, :price, :safety, :service, :cash_only, :english, :tips, :wifi, :wheelchair]
    params.require(:review).permit(allow)
  end

  def create
    @review = Review.new(review_params)
    respond_to do |format|
      if @review.save 
        flash[:notice] = 'Review was successfully created'
        format.html { redirect_to :action => "show", :id => @review["business_id"] }
      else
        formatl.html {render :action => "index"}
      end
    end
  end

  def yelp_help(food, city)
    search(food, city)
  end

  def yelp_help_location(food, lat, long)
    search_location(food, lat, long)
  end

end
