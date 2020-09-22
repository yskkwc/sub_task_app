require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @user = users(:john)
    #login_as(@user, scope: :user)
    @other_user = users(:tonny)
  end

  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
end
