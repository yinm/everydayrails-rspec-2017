require 'rails_helper'

RSpec.describe Project, type: :model do
  it "does not allow duplicate project names per user" do
    project = FactoryGirl.create(:project, name: "Test Project")
    puts "#{project.owner.inspect}"

    # aliasでFactoryを作ったら、aliasでアクセスしないといけない (owner is ok. not user)
    new_project = project.owner.projects.build(
      name: "Test Project",
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "allows two users to share a project name" do
    project = FactoryGirl.create(:project, name: "Test Project")
    other_project = FactoryGirl.create(:project, name: "Test Project")

    puts "#{project.name}"
    puts "#{project.owner.inspect}"

    puts "#{other_project.name}"
    puts "#{other_project.owner.inspect}"

    expect(other_project).to be_valid
  end

  describe "late status" do
    it "is late when the due date is past today" do
      project = FactoryGirl.create(:project, :due_yesterday)
      expect(project).to be_late
    end

    it "is on time when the due date is today" do
      project = FactoryGirl.create(:project, :due_today)
      expect(project).to_not be_late
    end

    it "is on time when the due date is in the future" do
      project = FactoryGirl.create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end
  end

  it "can have many notes" do
    project = FactoryGirl.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end
end
