require 'spec_helper'

describe Doorkeeper::UsersController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: "1246"
      response.should be_success
    end
  end

end
