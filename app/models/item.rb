class Item < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true
    validates :image, presence: true
    validates :price, presence: true

    belongs_to :shop
    has_and_belongs_to_many :orders
end
