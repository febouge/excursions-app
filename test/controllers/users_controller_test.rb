require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @adminUser = users(:testUser)
    @otherUser = users(:secondTestUser)
    @thirdUser = users(:thirdTestUser)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get :index
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    get :show, id: @adminUser
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @adminUser
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @adminUser, user: { name: @adminUser.name, email: @adminUser.email, phoneNumber: 911234567 }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when logged in as wrong user" do
    log_in_as(@otherUser)
    get :show, id: @adminUser
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@otherUser)
    get :edit, id: @adminUser
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@otherUser)
    patch :update, id: @adminUser, user: { name: @adminUser.name, email: @adminUser.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when logged in as non-admin user" do
    log_in_as(@otherUser)
    get :index
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should not redirect index when logged in as admin user" do
    log_in_as(@adminUser)
    get :index
    assert flash.empty?
  end

  test "should redirect destroy when not logged in" do
    log_in_as(@otherUser)
    assert_no_difference 'User.count' do
      delete :destroy, id: @otherUser
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when not admin user" do

    assert_no_difference 'User.count' do
      delete :destroy, id: @otherUser
    end
    assert_redirected_to login_url
  end

  test "should allow to deactivate users when logged in as admin user" do
    log_in_as(@adminUser)
    assert_difference 'User.where(active: true).count', -1 do
      delete :destroy, id: @otherUser
    end
    assert_redirected_to users_path
  end


end
