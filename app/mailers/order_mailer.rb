class OrderMailer < ApplicationMailer
  require "resend"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #


  def received
    @order = params[:order]
    text_content = <<-TEXT
    Dear #{@order.name}

    Thank you for your recent order from The Pragmatic Store.

    You ordered the following items:

    #{@order.line_items}

    We'll send you a separate e-mail when your order ships.

    TEXT
    puts text_content
    params = {
      "to": [ @order.email ],
      "from": "Sam Ruby <depot@example.com>",
      "subject": "Pragmatic Store Order Confirmation",
      "html": text_content
    }
    sent = Resend::Emails.send(params)
    puts sent
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order

    mail to: order.email, subject: "Pragmatic Store Order Shipped"
  end
end
