Feature: Create a menu bar
    As a developer
    I want a menu bar to show on every page
    So that I can quickly navigate the website

Scenario: Test for menu presence
    Given I am on the home page
    Then I should see class "menu"
    Then I should see id "tamu_logo"
    Then I should see id "vert_bar"
    Then I should see id "name_tag"
    Then I should see id "search"
    Then I should see id "help"
    Then I should see id "login"
