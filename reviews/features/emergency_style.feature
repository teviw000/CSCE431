Feature: Add a styling to the emergency page
As a user
So that I can see better looking emergency info
I want to add classes and ids to elements

Scenario: Test for header
    Given I am on the emergency page
    Then I should see class "emergency-background"
    Then I should see class "header1"

    Then I should see class "flex-container"
    Then I should see class "column"
    Then I should see id "tamu"
    
    Then I should see id "police"


    Given I am on the emergency page
    Then I should see class "flex-container"
    Then I should see class "column"
    Then I should see id "tamu_office"



