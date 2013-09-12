require 'spec_helper'

describe Doorkeeper::EventsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: "5392", starts_at: "2013-08-24T04:00:00Z", ends_at: "2013-08-24T09:00:00Z"
      response.should be_success
    end
  end

end
