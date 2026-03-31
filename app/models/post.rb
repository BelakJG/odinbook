class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :author, class_name: "User"
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy


  scope :self_and_following, ->(current_user) {
    where(author_id: current_user.followings.select(:id))
    .or(where(author_id: current_user.id)).order(created_at: :desc)
  }
end
