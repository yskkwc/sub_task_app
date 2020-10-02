require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                    password: "foobar", password_confirmation: "foobar")
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    john = users(:john)
    tonny  = users(:tonny)
    assert_not john.following?(tonny)
    john.follow(tonny)
    assert john.following?(tonny)
    assert tonny.followers.include?(john)
    john.unfollow(tonny)
    assert_not john.following?(tonny)
  end
end
