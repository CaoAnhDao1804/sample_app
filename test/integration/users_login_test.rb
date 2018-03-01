require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users :michael
  end

  test "login with remembering " do
    log_in_as(@user, remember_me: "1")
    assert_not_empty cookies["remember_token"]
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: "0")
    assert_empty cookies["remember_token"]
  end
end
