Feature: Merge Articles
  As an admin
  In edit a article
  I want to merge two articles

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Dont show merge article field in new article
    Given I follow "New Article"
    Then I should not see "Merge Articles"

  Scenario: Show merge article field in edit article for admin
    Given the following articles
    | title          | body       |
    | Test Article   | AAAAAAAAAA |
    And I follow "All Articles"
    And I follow "Test Article"
    Then I should see "Merge Articles"

  Scenario: Merge two articles remove second article
    Given the following articles
    | title          | body       |
    | Test Article   | AAAAAAAAAA |
    | Article Test   | BBBBBBBBBB |
    And I follow "All Articles"
    And I follow "Test Article"
    And I fill in "merge_with" with "4"
    And I press "Merge"
    And I follow "All Articles"
    Then I should not see "Article Test"

  Scenario: Should merge two articles
    Given the following articles
    | title          | body       | author |
    | Test Article   | AAAAAAAAAA | admin  |
    | Article Test   | BBBBBBBBBB | admin  |
    Given the following comments to article
    | body          | article       | author |
    | Comment One      | Test Article  | admin  |
    | Comment Two      | Article Test  | admin  |
    And I follow "All Articles"
    And I follow "Test Article"
    And I fill in "merge_with" with "4"
    And I press "Merge"
    And I go to the show page for article "Test Article"
    Then I should see "AAAAAAAAAA"
    Then I should see "BBBBBBBBBB"
    Then I should see "Comment One"
    Then I should see "Comment Two"

  Scenario: Should not merge articles with same id
    Given the following articles
    | title          | body       | author |
    | Test Article   | AAAAAAAAAA | admin  |
    | Article Test   | BBBBBBBBBB | admin  |
    And I follow "All Articles"
    And I follow "Test Article"
    And I fill in "merge_with" with "3"
    And I press "Merge"
    Then I should see "Error: The id of the articles may not be equal, and id's must exist"
    Then I should see "AAAAAAAAAA"
    Then I should not see "BBBBBBBBBB"

  Scenario: should not merge article with id nonexistent
    Given the following articles
    | title          | body       | author |
    | Test Article   | AAAAAAAAAA | admin  |
    | Article Test   | BBBBBBBBBB | admin  |
    And I follow "All Articles"
    And I follow "Test Article"
    And I fill in "merge_with" with "100"
    And I press "Merge"
    Then I should see "AAAAAAAAAA"
    Then I should see "Error: the article ID must exist"
