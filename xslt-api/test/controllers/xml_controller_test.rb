require 'test_helper'

class XmlControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should get format xml" do
    get '/', params: { format: :xml }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/xml'
  end
end
