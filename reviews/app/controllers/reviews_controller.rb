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
    # FOR VIWAT
    @avg_user_price = @user_reviews.map{ |review| review["price"]}.reduce(:+).to_f / @user_reviews.size 
    @avg_user_rating = @user_reviews.map{ |review| review["rating"]}.reduce(:+).to_f / @user_reviews.size
    # TODO search through display_address and delete commas and brackets

	
    # TODO search through categories.alias and delete underscore if they ahve them and capitalize letters
    @show_alias = [@yelp_review_info["categories"][0]["alias"]]
    

    # Tags for show page (bottom)

    # Find current day for hours separately by colo
    @hours_open = [@yelp_review_info["hours"][0]["open"][0]["start"],
                   @yelp_review_info["hours"][0]["open"][1]["start"],
                   @yelp_review_info["hours"][0]["open"][2]["start"],
                   @yelp_review_info["hours"][0]["open"][3]["start"],
                   @yelp_review_info["hours"][0]["open"][4]["start"],
                   @yelp_review_info["hours"][0]["open"][5]["start"],
                   @yelp_review_info["hours"][0]["open"][6]["start"]
                  ]

    @hours_open.each { |x|
    if 
      x.insert(2,":")
      if x[2] == ":" && x[3] == ":"
        x.tap {|s| s.slice!(2) }
      end 
    }
    @hours_closed = [@yelp_review_info["hours"][0]["open"][0]["end"],
                   @yelp_review_info["hours"][0]["open"][1]["end"],
                   @yelp_review_info["hours"][0]["open"][2]["end"],
                   @yelp_review_info["hours"][0]["open"][3]["end"],
                   @yelp_review_info["hours"][0]["open"][4]["end"],
                   @yelp_review_info["hours"][0]["open"][5]["end"],
                   @yelp_review_info["hours"][0]["open"][6]["end"]
                  ]
    @hours_closed.each { |y| 
      y.insert(2,":")
      if y[2] == ":" && y[3] == ":"
        y.tap {|s| s.slice!(2) }
      end 
    }    
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
