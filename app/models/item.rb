class Item < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true
    validates :image, presence: true
    validates :price, presence: true

    belongs_to :shop
end
