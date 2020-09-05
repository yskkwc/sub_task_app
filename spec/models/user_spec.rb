require 'rails_helper'

RSpec.describe User, type: :model do
  it "isn't less than 1 character" do
    user = User.new
    expect(user).not_to be_valid
  end
end
