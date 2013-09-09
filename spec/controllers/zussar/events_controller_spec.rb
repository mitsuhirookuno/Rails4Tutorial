require 'spec_helper'

describe Zussar::EventsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: '991003'
      response.should be_success
    end
  end

end
