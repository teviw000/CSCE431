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
      if !params['best_reviews'].blank?
        puts(params['best_reviews'])
        if params['best_reviews'] == 'true'
          @display_results = get_best_reviewed_first(@display_results)
        end
      end

      if !params['price'].blank?
        puts(params['price'])
        if params['price'] == 'high'
          @display_results = get_high_price_first(@display_results)
        end
        if params['price'] == 'low'
          @display_results = get_low_price_first(@display_results)
        end
      end

      tags = get_tags_from_params()

      if !tags.empty?
        # puts(tags)
        @display_results = get_tags_first(@display_results,tags)
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
    puts @yelp_review_info["hours"].nil?
    #@user_reviews is an array of type Review. See the types in reviews/db/schema.rb
    @user_reviews = Review.where(business_id: params[:id])

    # Anon names
    @anon_names = ["Rudder", "Zachary", "Mosher", "Heldenfels", "Moses", "Nagle", "Olsen", "Penberthy" , "Reed", "Thompson"]
    # Average user price
    if @user_reviews.map{ |review| review["price"]}.reduce(:+).to_f / @user_reviews.size == nil
      @avg_user_price = 0
    else
      @avg_user_price = @user_reviews.map{ |review| review["price"]}.reduce(:+).to_f / @user_reviews.size
    end
    # Average user rating
    if @user_reviews.map{ |review| review["rating"]}.reduce(:+).to_f / @user_reviews.size == nil
      @avg_user_rating = 0
    else
      @avg_user_rating = @user_reviews.map{ |review| review["rating"]}.reduce(:+).to_f / @user_reviews.size
    end
    # Average user safety
    if @avg_user_safety = @user_reviews.map{ |review| review["safety"]}.reduce(:+).to_f / @user_reviews.size == nil
      @avg_user_safety = 0
    else
      @avg_user_safety = @user_reviews.map{ |review| review["safety"]}.reduce(:+).to_f / @user_reviews.size
    end
    # Average user service
    if @avg_user_service = @user_reviews.map{ |review| review["service"]}.reduce(:+).to_f / @user_reviews.size == nil
      @avg_user_service = 0
    else
      @avg_user_service = @user_reviews.map{ |review| review["service"]}.reduce(:+).to_f / @user_reviews.size
    end

    # Majority tag values
    @user_bools = get_tags(@user_reviews)
    if @user_bools.include? ("cash_only")
      @avg_user_cash_only = 1
    else
      @avg_user_cash_only = 0
    end

    if @user_bools.include? ("english")
      @avg_user_english = 1
    else
      @avg_user_english = 1
    end

    if @user_bools.include? ("tips")
      @avg_user_tips = 1
    else
      @avg_user_tips = 1
    end

    if @user_bools.include? ("wifi")
      @avg_user_wifi = 1
    else
      @avg_user_wifi = 1
    end

    if @user_bools.include? ("wheelchair")
      @avg_user_wheelchair = 1
    else
      @avg_user_wheelchair = 1
    end

    # Address call
    @display_address = [@yelp_review_info["location"]["address1"],
                        @yelp_review_info["location"]["city"],
                        @yelp_review_info["location"]["state"],
                        @yelp_review_info["location"]["zip_code"],
                        ]
    # Alias capitalization
    @show_alias = @yelp_review_info["categories"][0]["alias"]
    @show_alias[0] = @show_alias[0].capitalize()

    # Get open hours for each day of the week
    begin
      hours = @yelp_review_info["hours"][0]["open"]
    rescue => exception
      hours = []
    end
    
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @hours = {
      "Monday" => "Closed",
      "Tuesday" => "Closed",
      "Wednesday" => "Closed",
      "Thursday" => "Closed",
      "Friday" => "Closed",
      "Saturday" => "Closed",
      "Sunday" => "Closed"
    }
    if (hours.length == 0)
      @hours.keys.each{|day| @hours[day] = "No Hours Posted"}
    else
      hours.each do |times|
        start = times["start"]
        start_string = ""
        end_ = times["end"]
        end_string = ""

        # Format start time
        if (start.to_i > 1200)
          # After noon
          start_string = (start.to_i - 1200).to_s + " pm"
        else 
          # Before noon
          start_string = (start.to_i).to_s + " am"
        end
        start_string = start_string.insert(1, ":")
        # Format end time
        if (end_.to_i > 1200)
          # After noon
          end_string = (end_.to_i - 1200).to_s + " pm"
        else 
          # Before noon
          end_string = (end_.to_i).to_s + " am"
        end
        end_string = end_string.insert(1, ":")

        # Format display string
        string_time = ""
        if (start == end_)
          string_time = "Open 24 Hours"
        elsif (end_.to_i < start.to_i)
          string_time = "Open 24 Hours to " + end_string
        else
          string_time = start_string + " - " + end_string
        end

        # Put display string in @hours for a specific day
        @hours[days[times["day"]]] = string_time
      end
    end
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
