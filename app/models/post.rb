class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :author, class_name: "User"
  has_many :comments, as: :commentable, dependent: :destroy
end
