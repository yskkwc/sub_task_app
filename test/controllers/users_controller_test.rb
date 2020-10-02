require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::ControllerHelpers

  def setup
    @user = users(:john)
    sign_in(@user)
  end

end
