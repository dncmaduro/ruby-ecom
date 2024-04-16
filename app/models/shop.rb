class Shop < ApplicationRecord
  validates :name, presence: true
	validates :description, presence: true
	validates :address, presence: true
	validates :cover, presence: true

	belongs_to :user

	has_many :items
end
