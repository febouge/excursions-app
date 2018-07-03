require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @user = users(:testUser)
    @deactivatedUser = users(:deactivatedTestUser)
  end

end
