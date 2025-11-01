class OrderMailer < ApplicationMailer
  require "resend"

  @@last_params = nil

  def initialize(order)
    @order =  order
    @param1 = {
      to: [ @order.email ],
      from: "Your App <onboarding@resend.dev>" # Must be a verified sender in Resend
    }
  end

  def show_last_params
    @@last_params
  end

  def send_it(params, method_name, content_type)
    params[content_type.to_sym] = render_to_string("#{File.basename(__FILE__, ".*")}/#{method_name}", layout: false)
    if Rails.env.test?
      @@last_params = params
    else
      begin
        Resend::Emails.send(params)
        Rails.logger.info "Resend email success: subject=#{params[:subject]}, to=#{params[:to]}"
      rescue Resend::Error => e
        Rails.logger.error "Resend email failed: #{e.message}"
      end
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject

  def received
      params = @param1.merge({
        subject: "Pragmatic Store order confirmation"
      })
      send_it(params, __method__, "text")
  end

  def shipped
      params = @param1.merge({
        subject: "Pragmatic Store order shipped"
      })
      send_it(params, __method__, "html")
  end
end
