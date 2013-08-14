require 'spec_helper'

describe DoorkeeperController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'events'" do
    it "returns http success" do
      get 'events', event_id: "806"
      response.should be_success
    end
  end

  describe "GET 'users'" do
    it "returns http success" do
      get 'users', group_id: "1246"
      response.should be_success
    end
  end

end
