require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
 include Devise::Test::IntegrationHelpers

 test "layout links" do
 	get root_path
 	assert_template 'static_pages/home'
 	assert_select "a[href=?]", root_path, count:2
 	assert_select "a[href=?]", about_path
 	assert_select "a[href=?]", link_path
 	assert_select "a[href=?]", privacy_path
 	assert_select "a[href=?]", terms_path
 end
end
