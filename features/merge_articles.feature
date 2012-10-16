Feature: Merge Articles
  As an admin
  In order to combine authors who write more than one article on the same topic
  I want to merge two articles into one article while preserving both articles' content

  Background:
 	Given the blog is set up
 	And I am logged into the admin panel
    And I am on the new article page
    When I fill in "article_title" with "foobar"
    And I fill in "article__body_and_extended_editor" with "foobar_content"
    And I fill in "article_author" with "foobar_author"
    And I press "Publish"
    Then I should be on the admin content page
    When I go to the home page
    Then I should see "foobar"
    When I follow "foobar"
    Then I should see "foobar_content"
    Given I am on the new article page
    When I fill in "article_title" with "helloworld"
    And I fill in "article__body_and_extended_editor" with "helloworld_content"
    And I press "Publish"
    Then I should be on the admin content page
    When I go to the home page
    Then I should see "helloworld"
    When I follow "helloworld"
    Then I should see "helloworld_content"

  Scenario: A non-admin cannot merge two articles
    Given I am on the edit article page for "foobar"
    Then I should not see "merge_with"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
	Given I am on the edit article page for "foobar"
    And I fill in "merge_with" with "4"
    And I press "Merge"
    Then I should be on the admin content page
    And I should see "foobar"
    Given I am on the edit article page for "foobar"
    Then the "article__body_and_extended_editor" field should contain "foobar_content"
    And the "article__body_and_extended_editor" field should contain "helloworld_content"

  Scenario: When articles are merged, the merged article should have one author (either one of the authors of the original article)
  	Given I am on the edit article page for "foobar"
  	And I fill in "merge_with" with "4"
  	And I press "Merge"
  	Then I should be on the admin content page
  	And I should see "foobar"
  	Given I am on the edit article page for "foobar"
  	Then the "author" field should contain "foobar_author"

  Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article

  Scenario: The title of the new article should be the title from either one of the merged articles
