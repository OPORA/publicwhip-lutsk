require 'test_helper'

class SumisneHolosuvanniaControllerTest < ActionDispatch::IntegrationTest
  test "should get init" do
    get sumisne_holosuvannia_init_url
    assert_response :success
  end

end
