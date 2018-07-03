require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

    def setup
        @user = users(:testUser)
    end

    test "unsuccessful edit" do
        log_in_as(@user)
        get edit_user_path(@user)
        assert_template 'users/edit'
        patch user_path(@user), user: { name:  "", surname: "test", phoneNumber: "999222111", email: "foo@invalid",         password: "foo", password_confirmation: "bar", active: 1, admin: 0 }
        assert_template 'users/edit'
    end

    test "successful edit" do
        log_in_as(@user)
        get edit_user_path(@user)
        assert_template 'users/edit'
        name  = "Testing"
        surname = "Testing Surname"
        phoneNumber = 999222111
        email = "testing@test.com"
        patch user_path(@user), user: { name:  name, surname: surname, phoneNumber: phoneNumber, email: email, password: "validtest", password_confirmation: "validtest", active: 1, admin: 0 }
        assert_not flash.empty?
        assert_redirected_to @user
        @user.reload
        assert_equal name,  @user.name
        assert_equal surname,  @user.surname
        assert_equal phoneNumber,  @user.phoneNumber
        assert_equal email, @user.email
    end
end
