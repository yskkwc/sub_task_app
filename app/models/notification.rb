class Notification < ApplicationRecord
  belongs_to :visiter,    class_name:  'User',
                          foreign_key: 'visiter_id',
                          optional:    true
  belongs_to :visited,    class_name:  'User',
                          foreign_key: 'visited_id',
                          optional:    true
  belongs_to :micropost,  optional:    true
  belongs_to :comment,    optional:    true

  default_scope->{order(created_at: :desc)}
end
