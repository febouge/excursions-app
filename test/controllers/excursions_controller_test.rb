require 'test_helper'

class ExcursionsControllerTest < ActionController::TestCase

  def setup
    @excursion = excursions(:validExcursion)
    @admin = users(:testUser)
    @nonadmin = users(:secondTestUser)
  end

  test "should redirect new when not logged in" do
    get :new
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect index when not logged in" do
    get :index
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    get :show, id: @excursion
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @excursion
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @excursion, excursion: { name: @excursion.name, busSpots: @excursion.busSpots, lunchSpots: 40, active: @excursion.active }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    delete :destroy, id: @excursion
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect download when not logged in" do
    post :download, id: @excursion, format: :csv
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect new when not logged in as admin" do
    log_in_as(@nonadmin)
    get :new
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in as admin" do
    log_in_as(@nonadmin)
    get :index
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect show when not logged in as admin" do
    log_in_as(@nonadmin)
    get :show, id: @excursion
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when not logged in as admin" do
    log_in_as(@nonadmin)
    get :edit, id: @excursion
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in as admin" do
    log_in_as(@nonadmin)
    patch :update, id: @excursion, excursion: { name: @excursion.name, busSpots: @excursion.busSpots, lunchSpots: 40, active: @excursion.active }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in as admin" do
    log_in_as(@nonadmin)
    delete :destroy, id: @excursion
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect download when not logged in as admin" do
    log_in_as(@nonadmin)
    post :download, id: @excursion, format: :csv
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should not redirect new when logged in as admin" do
    log_in_as(@admin)
    get :new
    assert flash.empty?
  end

  test "should redirect not index when logged in as admin" do
    log_in_as(@admin)
    get :index
    assert flash.empty?
  end

  test "should not redirect show when logged in as admin" do
    log_in_as(@admin)
    get :show, id: @excursion
    assert flash.empty?
  end

  test "should not redirect edit when logged in as admin" do
    log_in_as(@admin)
    get :edit, id: @excursion
    assert flash.empty?
  end

  test "should not redirect update when logged in as admin" do
    log_in_as(@admin)
    patch :update, id: @excursion, excursion: { name: @excursion.name, busSpots: @excursion.busSpots, lunchSpots: 40, active: true }
    assert_redirected_to excursion_url(@excursion.id)
  end

  test "should not redirect destroy when logged in as admin" do
    log_in_as(@nonadmin)
    delete :destroy, id: @excursion
    assert_not flash.empty?
  end

  test "should not redirect download when logged in as admin" do
    log_in_as(@nonadmin)
    post :download, id: @excursion, format: :csv
    assert_not flash.empty?
    assert_redirected_to root_url
  end

end
