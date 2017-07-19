require 'test_helper'

class HelpControllerTest < ActionController::TestCase
  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get data" do
    get :data
    assert_response :success
  end

  test "should get licencing" do
    get :licencing
    assert_response :success
  end

end
