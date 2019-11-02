require File.dirname(__FILE__) + '/yelpAPI'

class ReviewsController < ApplicationController
  def index
  end

  def new
  end

  def emergency
  end

  def yelp_help
    search('tacos', 'College Station')
  end
end
