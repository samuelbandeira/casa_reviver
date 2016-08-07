class Person < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 255}
  VALID_EMAIL_REGEX = /\A([\w+\-.]+@[a-z\d\-.]+\.[a-z]+|\s?)\z/i
  validates :email, presence: false, length: {maximum: 255}, uniqueness: true,
            format: { with: VALID_EMAIL_REGEX }

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "80x80#" }, default_url: ":style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  before_validation :down_case

  def down_case
    unless self.email.nil?
      self.email.squish!
      self.email.downcase!
    end
  end
end
