class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :commentable, polymorphic: true

  belongs_to :author, class_name: "User"
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
end
