class Like < ApplicationRecord
  validates :user, presence: true
  validates :user_id, uniqueness: { scope: [ :likeable_id, :likeable_type ], message: "User can not like same post/comment more than once" }

  belongs_to :user
  belongs_to :likeable, polymorphic: true
end
