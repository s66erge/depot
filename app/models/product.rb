class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  has_one_attached :image
  after_commit -> { broadcast_refresh_later_to "products" }
  validates :title, :description, :image, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  # validates :title, length: { minimum: 10 }
  validate :minimum_title_len
  validate :acceptable_image

  def acceptable_image
    return unless image.attached?
    acceptable_types = %w[image/gif image/jpeg image/png]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a GIF, JPG or PNG image")
    end
  end

  def minimum_title_len
    return unless title
    minimum_length = 10
    unless title.to_s.length > minimum_length
      errors.add(:title, "must be at least #{minimum_length} characters long")
    end
  end
end

def ensure_not_referenced_by_any_line_item
  unless line_items.empty?
    errors.add(:base, "Line Items present")
    throw :abort
  end
end
