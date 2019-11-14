Feature: create show page
    As a user
    So that I can see the details of any location from abroad trips
    I want to be informed of where I'm going

Scenario: Test the show page
    Given I am on the show_mad_taco page
    Then I should see "See Reviews Here"
    Then I should see "Rating"
    Then I should see "Price"
    Then I should see "Address"
    Then I should see "Hours"
    Then I should see "Phone Number"
