class FollowList < ApplicationRecord
  validates :user_id, presence: true
  validates :following_id, presence: true

  belongs_to :user
  belongs_to :following, class_name: "User"
end
