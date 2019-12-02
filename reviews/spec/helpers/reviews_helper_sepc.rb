require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ReviewsHelper, type: :helper do
  # pending "add some examples to (or delete) #{__FILE__}"

  #need to determine why its not getting businesses from the query

  describe "#search" do
    it "Checks that a search has a response with businesses" do
      response = helper.search("food","colleg station")
      expect(response["total"].to_i).to be > 0
    end    
  end

  describe "#search_location" do
    it "Checks that searching current location has a response with businesses" do
      # uses the lat and long of college station
      response = helper.search_location("food",30.613971800352598,-96.32022857666016)
      expect(response["total"].to_i).to be > 0
    end
  end

  describe "#business" do
    it "Checks if looking up a business is successful" do
      id = "_CgYVNP8zavac_XKLpKwoQ"
      name = "Howdy's Texas Grill'd Pizza"
      resposne = helper.business(id)
      expect(response.status).to eq 200
    end
  end

  describe "#get_display_results" do  
    
  end


end

