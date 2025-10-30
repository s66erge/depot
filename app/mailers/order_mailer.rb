class OrderMailer < ApplicationMailer
  require "resend"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  default from: 'no-reply@example.com'

  def received(order)
    # Resend.api_key = ENV["RESEND_API_KEY"]
    begin
      @order = order
      params = {
        "from": "Your App <onboarding@resend.dev>", # Must be a verified sender in Resend
        "to": order.email,
        "subject": "Pragmatic Store order confirmation",
        "text": render_to_string('order_mailer/received', layout: false)
      }
      Resend::Emails.send(params)
      Rails.logger.info "Resend email success"
    rescue Resend::Error => e
      Rails.logger.error "Resend email failed: #{e.message}"
    end
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
