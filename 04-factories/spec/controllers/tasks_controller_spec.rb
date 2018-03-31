require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project, owner: @user)
    @task = @project.tasks.create!(name: "Test task")
  end

  describe "#show" do
    it "responds with JSON formatted output" do
      sign_in @user
      get :show, format: :json,
        params: { project_id: @project.id, id: @task.id }
      expect(response.content_type).to eq "application/json"
    end
  end
end
