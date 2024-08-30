class Task < ApplicationRecord
  belongs_to :user
  belongs_to :board
  has_many :comments
  has_one_attached :image

  validates :name, presence: true
end
