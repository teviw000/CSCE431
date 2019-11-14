Feature: Add a Leave a Review Button
As a user
So that we can leave a review 
I want to go to create a review for a location

Scenario: Test Leave a Review Button
	Given I am on the show_mad_taco page
	Then I should see id "leave_review"
	Then I should see class "btn"
	When I follow "Leave A Review"
	Then I should see class "review_page"
