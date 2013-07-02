require 'spec_helper'

describe ZussarController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'users'" do
    it "returns http success" do
      get 'users', user_id: 'agxzfnp1c2Fhci1ocmRyFAsSBFVzZXIiCjY4MDcxMDJfdHcM'
      response.should be_success
    end
  end

end
