class Person < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 255}
  VALID_EMAIL_REGEX = /\A([\w+\-.]+@[a-z\d\-.]+\.[a-z]+|\s?)\z/i
  validates :email, length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX }
end
