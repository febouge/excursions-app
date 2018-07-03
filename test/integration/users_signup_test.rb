require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

    test "invalid signup information" do
        get new_user_path
        assert_no_difference 'User.count' do
            post users_path, user: { name:  "", surname: "Test", phoneNumber: "999888444",  email: "user@invalidMail", password: "foo", password_confirmation: "bar" }
        end
        assert_template 'users/new'
    end

    test "valid signup information" do
        get new_user_path
        assert_difference 'User.count', 1 do
            post_via_redirect users_path, user: { name:  "test", surname: "Test", phoneNumber: "999888444", email: "user@test.com", password: "password",password_confirmation: "password" }
        end
        assert_template "static_pages/home"
    end
end
