require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @user = users(:john)
    login_as(@user, scope: :user)
  end
  test "should get new" do
    get new_user_registration_path
    assert_response :success
  end

end
