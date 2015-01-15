require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  def setup 
    user = FactoryGirl.create(:user)
    sign_in user
  end

  test "new action" do
     get :new
     assert_response :success
  end

  test "create place" do
    post :create, :format => :json, :place => {:name => "random place", :address => "some park", :description => "rubbish"}
    assert_response :success
    message = ActiveSupport::JSON.decode @response.body 
    new_item_id = message['id']
    new_item = Place.find(new_item_id)
    assert_equal "random place", new_item.name
  end

end
