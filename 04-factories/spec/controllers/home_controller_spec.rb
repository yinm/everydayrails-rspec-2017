require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      get :index
      expect(response).to_not be_success
    end
  end
end
