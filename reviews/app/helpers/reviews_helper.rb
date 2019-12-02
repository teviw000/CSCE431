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
        response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
        response.parse
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
        # puts(response)
        return response.parse
    end

    def get_display_results(yelp_result)
        display_results = []
        if (!yelp_result.is_a?(Hash))
            puts "not a hash"
            return display_results
        end
        if (!yelp_result.key?("businesses"))
            puts "no businesses"
            return display_results
        end
        yelp_result["businesses"].each do |biz|
            display_results.push(build_display_result(biz))
        end
        return display_results
    end

    def build_display_result(business)
        result = Hash.new
        result["id"] = business["id"]
        result["name"] = business["name"]
        result["image"] = business["image_url"]
        if (business["categories"].length > 0)
            result["type"] = business["categories"][0]["title"]
        else
            result["type"] = "No Business Type"
        end
        result["address"] = business["location"]["address1"]

        student_reviews = Review.where(business_id: business["id"])
        if (student_reviews.length == 0)
            result["price"] = -1
            result["rating"] = -1
            result["service"] = -1
            result["safety"] = -1
            result["tags"] = []
        else 
            
            result["price"] = get_average(student_reviews, "price")
            result["rating"] = get_average(student_reviews, "rating")
            result["service"] = get_average(student_reviews, "service")
            result["safety"] = get_average(student_reviews, "safety")
            result["tags"] = get_tags(student_reviews)
        end
        return result
    end

    def get_average(reviews, key)
        count = 0
        total = 0
        reviews.each do |review| 
            if (review[key].is_a?(Numeric))
                total = total + review[key]
                count = count + 1
            end
        end
        return (total / count)
    end

    def get_tags(reviews)
        count = reviews.length
        cash_only_count = 0
        english_count = 0
        tips_count = 0
        wifi_count = 0
        wheelchair_count = 0
        reviews.each do |review|
            if (review["cash_only"] == true)
                cash_only_count += 1
            end
            if (review["english"] == true)
                english_count += 1
            end
            if (review["tips"] == true)
                tips_count += 1
            end
            if (review["wifi"] == true)
                wifi_count += 1
            end
            if (review["wheelchair"] == true)
                wheelchair_count += 1
            end
        end
        tags = []
        if (cash_only_count > count/2)
            tags.push("cash_only")
        end
        if (english_count > count / 2)
            tags.push("english")
        end
        if (tips_count > count / 2)
            tags.push("tips")
        end
        if (wifi_count > count / 2)
            tags.push("wifi")
        end
        if (wheelchair_count > count / 2)
            tags.push("wheelchair")
        end
        return tags
    end

    def get_correct_order(old_results)
        new_results = []
        old_results.each_with_index do |result, index|
            if (result["rating"] != -1)
                # If this review has student reviews, put it at the beginning of the new array
                new_results.push(old_results.delete_at(index))
            end 
        end
        new_results += old_results
        return new_results
    end
end
