Feature: create review page
    As a user
    So that I can add reviews to places I have been
    I want to give feedback on trips abroad

Scenario: Test for review presence
    Given I am on the review page
    Then I should see class "review_page"
    Then I should see class "review_text"

Scenario: Test for all features
    Given I am on the review page
    Then I should see class "review_text"
    Then I should see class "rating"
    Then I should see class "safety"
    Then I should see class "price"
    Then I should see class "food"
    Then I should see class "service"
    Then I should see class "cash"
    Then I should see class "english"
    Then I should see class "tips"
    Then I should see class "wifi"
    Then I should see class "submit_cancel"