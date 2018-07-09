require 'test_helper'

class PolicyDivisionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @policy_division = policy_divisions(:one)
  end

  test "should get index" do
    get policy_divisions_url
    assert_response :success
  end

  test "should get new" do
    get new_policy_division_url
    assert_response :success
  end

  test "should create policy_division" do
    assert_difference('PolicyDivision.count') do
      post policy_divisions_url, params: { policy_division: { policy_id: @policy_division.policy_id, support: @policy_division.support, vote_id: @policy_division.vote_id } }
    end

    assert_redirected_to policy_division_url(PolicyDivision.last)
  end

  test "should show policy_division" do
    get policy_division_url(@policy_division)
    assert_response :success
  end

  test "should get edit" do
    get edit_policy_division_url(@policy_division)
    assert_response :success
  end

  test "should update policy_division" do
    patch policy_division_url(@policy_division), params: { policy_division: { policy_id: @policy_division.policy_id, support: @policy_division.support, vote_id: @policy_division.vote_id } }
    assert_redirected_to policy_division_url(@policy_division)
  end

  test "should destroy policy_division" do
    assert_difference('PolicyDivision.count', -1) do
      delete policy_division_url(@policy_division)
    end

    assert_redirected_to policy_divisions_url
  end
end
