require "test_helper"

class ProductTest < ActiveSupport::TestCase

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image].any?
  end

  test "product price must be positive" do
    product = Product.new(title:       "My Book Title",
                          description: "yyy")
    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"),
                         filename: "lorem.jpg", content_type: "image/jpeg")
    product.price = -1
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ],
                 product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ],
                 product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(filename, content_type)
    Product.new(
      title:       "My Book Title",
      description: "yyy",
      price:       1
    ).tap do |product|
      product.image.attach(
        io: File.open("db/images/#{filename}"), filename:, content_type:)
    end
  end

  test "image url" do
    product = new_product("lorem.jpg", "image/jpeg")
    assert product.valid?, "image/jpeg must be valid"

    product = new_product("logo.svg", "image/svg+xml")
    assert_not product.valid?, "image/svg+xml must be invalid"
  end

  # test "the truth" do
  #   assert true
  # end
end
