require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  def setup
    Warden.test_mode!
    @user = users( :john )
    login_as(@user, :scope => :user)
  end
end
