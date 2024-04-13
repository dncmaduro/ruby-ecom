# Outside the class (optional)
EMAIL_REGEX = /\A[a-zA-Z0-9_\-\.]+@[a-zA-Z0-9_\-\.]+\.[a-zA-Z]{2,}\z/
PHONE_REGEX = /^(?:\+84|0)\s*(?:\d{3}\s*){3}$/

class User < ApplicationRecord
  VALID_ROLES = %w(ADMIN MANAGER CUSTOMER)  # Use %w shortcut for string arrays

  validates :email, presence: true, format: { with: EMAIL_REGEX, message: "Invalid email format" }
  validates :dob, presence: true
  validates :role, inclusion: { in: VALID_ROLES, message: "Invalid role" }
  validates :address, presence: true
  validates :phone, presence: true, length: { minimum: 10 }

  has_secure_password

end
