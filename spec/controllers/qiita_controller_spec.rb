require 'spec_helper'

describe QiitaController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'tags'" do
    it "returns http success" do
      get 'tags', tag: 'Linux'
      response.should be_success
    end
  end

  describe "GET 'users'" do
    it "returns http success" do
      get 'users'
      response.should be_success
    end
  end

end
