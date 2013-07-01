require 'spec_helper'

describe TopController do

  describe "GET 'index'" do
    
    it "returns http success" do
      
      @user = User.new(:name => "rspec", :password => "rspec", :password_confirmation => "rspec")
      @controller.stubs(:current_user).returns(@user)
      
      get 'index'
      
      response.should be_success
      
    end
    
  end

end
