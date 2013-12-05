require 'spec_helper'

describe Atnd::EventsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: 'MjI1MjAvMA==%0A'
      response.should be_success
    end
  end

end
