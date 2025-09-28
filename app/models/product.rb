class Product < ApplicationRecord
  has_one_attached :image
  after_commit -> { broadcast_refresh_later_to "products" }
  validates :title , :description , :image , presence: true
  validates :title , uniqueness: true
  validates :price , numericality: { greater_than_or_equal_to: 0.01 }
  #validates :title, length: { minimum: 10 }
  validate :minimum_title_len
  validate :acceptable_image
  def acceptable_image
    return unless image.attached?
    acceptable_types = [ "image/gif", "image/jpeg", "image/png" ]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a GIF, JPG or PNG image")
    end
  end
  def minimum_title_len
    minimum_length = 10
    unless :title.length > minimum_length
      errors.add(:title, "must be at least #{minimum_length} characters long")
    end
  end
end
