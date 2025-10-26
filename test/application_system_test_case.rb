require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  Capybara.default_max_wait_time = 5  # Increase wait time for Turbo
=begin
  setup do
    Capybara.current_driver = :selenium_chrome_headless
    Capybara.javascript_driver = :selenium_chrome_headless
  end
=end

  # Helper method to log in a user in system tests
  def login_system(user, password: "password")
    visit new_session_url  # Adjust to your actual login path
    fill_in placeholder: "Enter your email address", with: user.email_address
    fill_in placeholder: "Enter your password", with: password
    click_button "Sign in"
    assert_no_current_path new_session_url
  end
end
