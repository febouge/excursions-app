require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:testUser)
    @deactivatedUser = users(:deactivatedTestUser)
  end

  test "login with valid information" do
    get login_path
    post login_path, session: { email: @user.email, password: "password" }
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get excursions_path
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with deactivatedUser" do
    get login_path
    post login_path, session: { email: @deactivatedUser.email, password: 'password' }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
  end
end
