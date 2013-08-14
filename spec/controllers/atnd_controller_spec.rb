require 'spec_helper'

describe AtndController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'events'" do
    it "returns http success" do
      get 'events', event_id: "45236"
      response.should be_success
    end
  end

  describe "GET 'users'" do
    it "returns http success" do
      get 'users', owner_id: 90907
      response.should be_success
    end
  end

end
