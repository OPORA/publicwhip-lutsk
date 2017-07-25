require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get divisions" do
    get api_divisions_url
    assert_response :success
  end

  test "should get mp" do
    get api_mp_url
    assert_response :success
  end

end
