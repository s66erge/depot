require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    login_system(@user)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "should update User" do
    visit user_url(@user)
    click_link "Edit this user", match: :first
    assert_no_current_path user_url(@user)
    fill_in "user_email_address", with: @user.email_address
    fill_in "user_name", with: @user.name
    fill_in "user_password", with: "secret2"
    fill_in "user_password_confirmation", with: "secret2"
    find_field("user_password_confirmation").send_keys(:tab)
    click_button "Update User"
    assert_current_path users_url
    assert_text "was successfully updated"
    page.go_back
  end

  test "should destroy User" do
    visit user_url(@user)
    accept_confirm do
      click_button "Destroy this user"
    end
    assert_no_current_path user_url(@user)
    assert_text "User was successfully destroyed"
  end

  test "should create user" do
    visit users_url
    click_link "New user"
    assert_no_current_path users_url
    fill_in "user_name", with: "zero"
    fill_in "user_email_address", with: "zero@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    find_field("user_password_confirmation").send_keys(:tab)
    click_button "Create User"
    assert_no_current_path new_user_url
    assert_text "was successfully created"
    page.go_back
  end
end
