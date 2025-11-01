require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    params = OrderMailer.new(orders(:one)).received
    assert_equal "Pragmatic Store order confirmation", params[:subject]
    assert_equal "dave@example.org", params[:to].first
    assert_match(/1 x The Pragmatic Programmer/, params[:text])
  end

  test "shipped" do
    params = OrderMailer.new(orders(:one)).shipped
    assert_equal "Pragmatic Store order shipped", params[:subject]
    assert_equal "dave@example.org", params[:to].first
    assert_match %r{
      <td[^>]*>1<\/td>\s*
      <td>&times;<\/td>\s*
      <td[^>]*>\s*The\sPragmatic\sProgrammer\s*</td>
    }x, params[:html]
  end
end
