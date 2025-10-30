class Mailform
  def render_template(file_path, locals = {})
    template = File.read(file_path)
    # Create a binding with locals as instance variables
    context = Object.new
    locals.each do |key, value|
      context.instance_variable_set("@#{key}", value)
    end
    ERB.new(template).result(context.instance_eval { binding })
  end

  def self.received(order)
    line_items_str = order.line_items.map do |item|
      "- #{item.quantity} x #{item.product.title} @ #{item.product.price}"
    end.join("\n\n")
    text_content = <<-TEXT
    Dear #{order.name}

    Thank you for your recent order from The Pragmatic Store.

    You ordered the following items:

    #{line_items_str}

    We'll send you a separate e-mail when your order ships.

    TEXT
    params = {
      "to": [ order.email ],
      "from": "Acme <onboarding@resend.dev>",
      "subject": "Pragmatic Store Order Confirmation",
      "html": text_content
    }
    params
  end
end
