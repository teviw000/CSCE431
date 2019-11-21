##########################################################################################
## This file is from https://github.com/Yelp/yelp-fusion/blob/master/fusion/ruby/sample.rb
##########################################################################################
require "json"
require "http"
require "optparse"
module ReviewsHelper
    # Place holders for Yelp Fusion's API key. Grab it
    # from https://www.yelp.com/developers/v3/manage_app
    API_KEY = "I8-CjEP4T1mcf5wRmihQCQ1A25o8Pmfr4GD0vzcxuxRn9P1y1aQQOkU5UHSIBXLRjPGXnNaDysZSPGWNAFunxBnmWjdSCl7mT5EuS11RFXjTRuxPdto2DqJs9166XXYx"


    # Constants, do not change these
    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path


    DEFAULT_BUSINESS_ID = "yelp-san-francisco"
    DEFAULT_TERM = "dinner"
    DEFAULT_LOCATION = "San Francisco, CA"
    SEARCH_LIMIT = 5


    # Make a request to the Fusion search endpoint. Full documentation is online at:
    # https://www.yelp.com/developers/documentation/v3/business_search
    #
    # term - search term used to find businesses
    # location - what geographic location the search should happen
    #
    # Examples
    #
    #   search("burrito", "san francisco")
    #   # => {
    #          "total": 1000000,
    #          "businesses": [
    #            "name": "El Farolito"
    #            ...
    #          ]
    #        }
    #
    #   search("sea food", "Seattle")
    #   # => {
    #          "total": 1432,
    #          "businesses": [
    #            "name": "Taylor Shellfish Farms"
    #            ...
    #          ]
    #        }
    #
    # Returns a parsed json object of the request
    def search(term, location)
        url = "#{API_HOST}#{SEARCH_PATH}"
        params = {
            term: term,
            location: location,
        }
        response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
        response.parse
    end

    def search_location(term, latitude, longitude)
        url = "#{API_HOST}#{SEARCH_PATH}"
        params = {
            term: term,
            latitude: latitude,
            longitude: longitude,
        }
        reponse = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
        reponse.parse
    end


    # Look up a business by a given business id. Full documentation is online at:
    # https://www.yelp.com/developers/documentation/v3/business
    # 
    # business_id - a string business id
    #
    # Examples
    # 
    #   business("yelp-san-francisco")
    #   # => {
    #          "name": "Yelp",
    #          "id": "yelp-san-francisco"
    #          ...
    #        }
    #
    # Returns a parsed json object of the request
    def business(business_id)
        url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"
        response = HTTP.auth("Bearer #{API_KEY}").get(url)
        response.parse
    end
end
