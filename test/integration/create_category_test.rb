require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com",
                              password: "password", admin: true)
    sign_in_as(@admin_user)
  end

  # what are we doing in this test? thats the title
  test "get new category form and create category" do
    sign_in_as(@admin_user)
    # so step one should be to see if we can even get to the page for the action 
    get "/categories/new"
    assert_response :success

    # # now we want to see if we can complete the action, in this case it is a post
    # # the code below is checking to see if the Category table records increases by 1 in the do block
    # assert_difference 'Category.count', 1 do

    #   # this is just saying do a post action to the categories path, then we are setting the params hash which just contains a category object
    #   post categories_path, params: { category: { name: "sports2"} }

    #   # now we want to make sure there is a redirect
    #   assert_response :redirect
    # end

    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: "Sports" } }
    end

    # now follow the redirect and see where it takes us
    follow_redirect!

    # make sure we are able to follow the redirect
    assert_response :success

    # now we want to make sure that the name of the category we just made appears on the page we directed to
    # so we can search the body of the HTML body to see if its there
    assert_match "Sports", response.body
  end

  # test "get new category form and reject invalid category submission"

  #   # so step one should be to see if we can even get to the page for the action 
  #   get "/categories/new"
  #   assert_response :success

  #   # now we want to see if the submission is rejected
  #   # this makes sure that the number of rows in the category table are the same
  #   assert_no_difference 'Category.count' do

  #     # this is just saying do a post action to the categories path, then we are setting the params hash which just contains a category object
  #     post categories_path, params: { category: { name: ""} }
  #   end

  #   # make sure the error validation messages show up
  #   # so we can test for the html elements that are unique to the errors message box that are in the _errors.html.erb partial
  #   assert_match "errors", response.body
  #   assert_select 'div.alert'
  #   assert_select 'h4.alert-heading'

  # end

  test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " "} }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h2.alert-heading'
  end
end

