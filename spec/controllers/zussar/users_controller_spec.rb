require 'spec_helper'

describe Zussar::UsersController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: 'agxzfnp1c2Fhci1ocmRyFAsSBFVzZXIiCjY4MDcxMDJfdHcM'
      response.should be_success
    end
  end

end
