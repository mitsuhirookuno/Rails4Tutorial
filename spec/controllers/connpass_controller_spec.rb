require 'spec_helper'

describe ConnpassController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', { event_id: 2907 }
      response.should be_success
    end
  end

  describe "GET 'users'" do
    it "returns http success" do
      get 'users', { nickname: 'umekumi' }
      response.should be_success
    end
  end

end
