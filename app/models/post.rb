class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_many :comments, as: :commentable, dependent: :destroy
end
