require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create_user' do
    it "is valid with name, email, password" do
      user = User.new(name:     "bob",
                      email:    "bob@example.com",
                      password: "password"
                      )
      expect(user).to be_valid
    end
  end
end
