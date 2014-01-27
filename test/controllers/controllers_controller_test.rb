require 'test_helper'

class ControllersControllerTest < ActionController::TestCase
  test "should get omniauth_callbacks" do
    get :omniauth_callbacks
    assert_response :success
  end

end
