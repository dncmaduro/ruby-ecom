class Order < ApplicationRecord
    VALID_STATUSES = %w(UNPAID PAID DONE FAILED)

    validates :price, presence: true
    validates :status, presence: true, inclusion: { in: VALID_STATUSES, message: "Invalid status" }

    belongs_to :user
end
