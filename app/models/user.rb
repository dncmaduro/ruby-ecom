# Outside the class (optional)
EMAIL_REGEX = /\A[a-zA-Z0-9_\-\.]+@[a-zA-Z0-9_\-\.]+\.[a-zA-Z]{2,}\z/
PASSWORD_REGEX = /(?i)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&*\(\)\[\]\{\}\'\"\<\>\,\.\/\?])(.*{8,})/
PHONE_REGEX = /^(?:\+84|0)\s*(?:\d{3}\s*){3}$/

class User < ApplicationRecord
  VALID_ROLES = %w(ADMIN MANAGER CUSTOMER)  # Use %w shortcut for string arrays

  validates :email, presence: true, format: { with: EMAIL_REGEX, message: "Invalid email format" }
  validates :password, presence: true, length: { minimum: 8 }, format: { with: PASSWORD_REGEX, message: "Password must be at least 8 characters and include a lowercase letter, uppercase letter, number, and special character" }
  validates :dob, presence: true
  validates :role, inclusion: { in: VALID_ROLES, message: "Invalid role" }
  validates :address, presence: true
  validates :phone, presence: true, length: { minimum: 10 }
end
