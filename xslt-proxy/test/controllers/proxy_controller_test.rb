require 'test_helper'

class ProxyControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get proxy_input_url
    assert_response :success
  end

  test "should get output" do
    get proxy_output_url
    assert_response :success
  end

  test "should get xml" do
    get proxy_output_url, params: { num: 4, side: :client }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/xml'
  end

  test "should get html after server" do
    get proxy_output_url, params: { num: 6, side: :server }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'text/html'
  end

  test "should get xml in browser" do
    get proxy_output_url, params: { num: 6, side: 'client-with-xslt' }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/xml'
  end

end
