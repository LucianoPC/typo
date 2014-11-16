Feature: Create Blog
  As an admin
  In need of create or edit a category
  I want to create or edit a category

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Create or edit category page shown
    Given I follow "Categories"
    Then I should see "Name"
    Then I should see "Keywords"
    Then I should see "Permalink"
    Then I should see "Description"
