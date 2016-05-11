class Person < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 255}
  VALID_EMAIL_REGEX = /\A([\w+\-.]+@[a-z\d\-.]+\.[a-z]+|\s?)\z/i
  validates :email, length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX }

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
