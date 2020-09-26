class Like < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  validates_uniqueness_of :micropost_id, scope: :user_id
end
