require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:testUser)
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "name should be invalid by length minimum" do
    @user.name = "a"
    assert_not @user.valid?
  end

  test "name should be invalid by length maximum" do
    @user.name = "a"*100
    assert_not @user.valid?
  end

  test "name should be invalid by no presence" do
    @user.name = nil
    assert_not @user.valid?
  end

  test "surname should be invalid by length minimum" do
    @user.surname = "a"
    assert_not @user.valid?
  end

  test "surname should be invalid by length maximum" do
    @user.surname = "a"*150
    assert_not @user.valid?
  end

  test "surname should be invalid by no presence" do
    @user.surname = nil
    assert_not @user.valid?
  end

  test "phone number should be invalid by length" do
    @user.phoneNumber = 12
    assert_not @user.valid?
  end

  test "phone number should be invalid by no presence" do
    @user.phoneNumber = nil
    assert_not @user.valid?
  end

  test "email should be invalid by format" do
    @user.email = "test.test@test"
    assert_not @user.valid?
  end

  test "email should be invalid by no presence" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "email should be unique" do
    userDupped = @user.dup
    @user.save
    assert_not userDupped.valid?
  end

  test "email should be unique Uppercase test" do
    userDupped = @user.dup
    userDupped.email = userDupped.email.upcase
    @user.save
    assert_not userDupped.valid?
  end

  test "email should not have two dots in domain" do
    @user.email = "example@test..com"
    assert_not @user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

  test "password should be not nil" do
    @user.password = @user.password_confirmation = nil
    assert_not @user.valid?
  end

end
