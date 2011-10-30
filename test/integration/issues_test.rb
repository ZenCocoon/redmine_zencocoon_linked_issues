require File.expand_path('../../test_helper', __FILE__)

class LinkedIssuesTest < ActionController::IntegrationTest
  include Capybara::DSL

  fixtures :projects,
           :users,
           :roles,
           :members,
           :issues

  def test_add_linked_issue_from_main_project
    visit '/login'
    fill_in "Login", :with => 'admin'
    fill_in "Password", :with => 'admin'
    click_on "Login »"

    # Ensure the link to create linked issue is present
    visit '/projects/ecookbook/issues/1'
    assert_equal "Create a PROD ticket", find('#create_linked_issue').text

    # Follow link and create new linked issue then continue
    click_link "Create a PROD ticket"
    fill_in "Subject", :with => "Linked Issue #1"
    click_on "Create and continue"

    # Create new linked issue then stop
    fill_in "Subject", :with => "Linked Issue #2"
    select '20', :from => "% Done"
    click_on "Create"

    # Ensure we are back to initial issue
    assert_equal '/issues/1', current_path
    assert page.find('#relations').text.match("Linked Issue #1")
    assert page.find('#relations').text.match("Linked Issue #2")
    assert page.find('#relations').text.match("20%")
  end

  def test_add_linked_issue_from_second_project
      visit '/login'
      fill_in "Login", :with => 'admin'
      fill_in "Password", :with => 'admin'
      click_on "Login »"

      # Ensure cross-project issue relations are allowed
      visit '/settings?tab=issues'
      check 'settings_cross_project_issue_relations'
      click_on 'Save'

      # Ensure the link to create linked issue is present
      visit '/projects/onlinestore/issues/4'
      assert_equal "Create a PROD ticket", find('#create_linked_issue').text

      # Follow link and create new linked issue then continue
      click_link "Create a PROD ticket"
      fill_in "Subject", :with => "Linked Issue #1"
      click_on "Create and continue"

      # Create new linked issue then stop
      fill_in "Subject", :with => "Linked Issue #2"
      select '20', :from => "% Done"
      click_on "Create"

      # Ensure we are back to initial issue
      assert_equal '/issues/4', current_path
      assert page.find('#relations').text.match('eCookbook')
      assert page.find('#relations').text.match("Linked Issue #1")
      assert page.find('#relations').text.match("Linked Issue #2")
      assert page.find('#relations').text.match("20%")
    end

  def test_permissions_on_linked_issue
    Member.edit_membership(3, { "role_ids" => [ '2' ] }, User.find(2)).save

    visit '/login'
    fill_in "Login", :with => 'jsmith'
    fill_in "Password", :with => 'jsmith'
    click_on "Login »"

    # Ensure the link to create linked issue is present
    visit '/projects/onlinestore/issues/4'
    assert find('#relations')
    assert_raise Capybara::ElementNotFound do
      find('#create_linked_issue')
    end
  end
end