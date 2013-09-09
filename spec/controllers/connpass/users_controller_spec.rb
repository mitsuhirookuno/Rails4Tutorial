require 'spec_helper'

describe Connpass::UsersController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: 'umekumi'
      response.should be_success
    end
  end

end
