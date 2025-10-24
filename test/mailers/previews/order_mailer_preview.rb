# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/received
  def received(order)
    @order = order

    mail to: order.email, subject: "Pragmatic Store Order Confirmation"
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/shipped
  def shipped(order)
    @order = order

    mail to: order.email, subject: "Pragmatic Store Order Shipped"
  end
end
