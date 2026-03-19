class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, class_name: "Post", foreign_key: "author_id", dependent: :destroy
  has_many :comments, class_name: "Comment", foreign_key: "author_id", dependent: :destroy

  has_many :follow_lists, foreign_key: :user_id, dependent: :destroy
  has_many :followings, through: :follow_lists, source: :following

  has_many :inverse_follow_lists, foreign_key: :following_id, class_name: "FollowList", dependent: :destroy
  has_many :followers, through: :inverse_follow_lists, source: :user
end
