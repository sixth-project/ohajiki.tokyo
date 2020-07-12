require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Ohajiki Tokyo"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | Ohajiki Tokyo"
  end

  test "should get link" do
    get :link
    assert_response :success
    assert_select "title", "Link | Ohajiki Tokyo"
  end


  test "should get privacy" do
    get :privacy
    assert_response :success
    assert_select "title", "Privacy Policy | Ohajiki Tokyo"
  end

  test "should get terms" do
    get :terms
    assert_response :success
    assert_select "title", "Terms of Use | Ohajiki Tokyo"
  end

end
