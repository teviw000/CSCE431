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

  describe "#search", type: :request do
    it "response to a search location" do
      response = helper.search("&find=food","?near=colleg station")
      puts(response)
      expect(response[:length].to_i).to be > 0
    end    
  end

  describe "#search_location", type: :request do
    it "response to searching current locatoin" do
      # uses the lat and long of college station
      response = helper.search_location("&find=food",30.613971800352598,-96.32022857666016)
      expect(response[:length].to_i>0).to be > 0
    end
  end

  describe "#business", type: :request do
    it "looking up a specific business" do
      id = "_CgYVNP8zavac_XKLpKwoQ"
      name = "Howdy's Texas Grill'd Pizza"
      resposne = helper.business(id)
      puts(response)
      expect(response[:namne]).to eq(name)
    end
  end
end

