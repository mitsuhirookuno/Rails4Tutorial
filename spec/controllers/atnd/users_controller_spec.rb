require 'spec_helper'

describe Atnd::UsersController do


  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: 'C00000069208'
      response.should be_success
    end
  end

end
