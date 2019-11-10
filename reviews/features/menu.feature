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
    Then I should see id "contact"
    Then I should see id "login"

Scenario: Test get help link
    Given I am on the home page
    When I follow "contact"
    Then I should see class "emergency"

Scenario: Test the logo links back to index
    Given I am on the home page
    When I follow "tamu_logo_link"
    Then I should see class "menu"
    When I follow "vert_bar_link"
    Then I should see class "menu"
    When I follow "name_tag_link"
    Then I should see class "menu"
