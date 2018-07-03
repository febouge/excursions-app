require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  def setup
    @registration = registrations(:validRegistration)
    @noregistration = registrations(:noValidRegistration)
  end

  test "registration should be valid" do
    assert @registration.valid?
  end

  test "registration should not be valid" do
    assert_not @noregistration.valid?
  end

  test "registration name should not be valid by length" do
    @registration.name = "n"
    assert_not @registration.valid?
    @registration.name = "n"*100
    assert_not @registration.valid?
  end

  test "registration name should not be valid by format" do
    @registration.name = "n91238"
    assert_not @registration.valid?
  end

  test "registration phone should not be valid by length" do
    @registration.phoneNumber = 999
    assert_not @registration.valid?
    @registration.phoneNumber = 99999999999
    assert_not @registration.valid?
  end

  test "registration phone should not be valid by format" do
    @registration.phoneNumber = "phoneNumb"
    assert_not @registration.valid?
  end

  test "registration email should not be valid" do
    @registration.email = "failmail"
    assert_not @registration.valid?
  end

  test "registration busSpots should not be valid" do
    @registration.busSpots = -1
    assert_not @registration.valid?
  end

  test "registration busSpots should be valid" do
    @registration.busSpots = 0
    assert @registration.valid?
  end

  test "registration busSpots should not accept decimal values" do
    @registration.busSpots = -3.14
    assert_not @registration.valid?
  end

  test "registration lunchSpots should not be valid" do
    @registration.lunchSpots = -2
    assert_not @registration.valid?
  end

  test "registration lunchSpots should be valid" do
    @registration.lunchSpots = 0
    assert @registration.valid?
  end

  test "registration lunchSpots should not accept decimal value" do
    @registration.lunchSpots = 1.45
    assert_not @registration.valid?
  end

end
