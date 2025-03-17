require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do
  it 'exists' do
    resource_category = ResourceCategory.new
    expect(resource_category).to be_a(ResourceCategory)
  end

  it 'has attributes' do
    resource_category = ResourceCategory.new
    expect(resource_category).to respond_to(:name)
    expect(resource_category).to respond_to(:active)
  end

  it { should have_and_belong_to_many(:organizations) }
  it { should have_many(:tickets) }

  describe "validations" do
    subject { ResourceCategory.new(name: "Shelter", active: true) }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe ".active" do
    it "returns resource categories that are active" do
      active_category = FactoryBot.create(:resource_category, name: "Food", active: true)
      inactive_category = FactoryBot.create(:resource_category, name: "Medical", active: false)
      expect(ResourceCategory.active).to include(active_category)
      expect(ResourceCategory.active).not_to include(inactive_category)
    end
  end

  describe ".inactive" do
    it "returns resource categories that are inactive" do
      inactive_category = FactoryBot.create(:resource_category, name: "Medical", active: false)
      active_category = FactoryBot.create(:resource_category, name: "Food", active: true)
      expect(ResourceCategory.inactive).to include(inactive_category)
      expect(ResourceCategory.inactive).not_to include(active_category)
    end
  end

  describe ".unspecified" do
    it "returns a resource category with the name 'Unspecified'" do
      category = ResourceCategory.unspecified
      expect(category.name).to eq("Unspecified")
    end
  end

  describe "#activate" do
    it "activates the resource category" do
      category = FactoryBot.create(:resource_category, active: false)
      category.activate
      expect(category.active).to be true
    end
  end

  describe "#deactivate" do
    it "deactivates the resource category" do
      category = FactoryBot.create(:resource_category, active: true)
      category.deactivate
      expect(category.active).to be false
    end
  end

  describe "#inactive?" do
    it "returns true if the resource category is inactive" do
      category = FactoryBot.build(:resource_category, active: false)
      expect(category.inactive?).to be true
    end

    it "returns false if the resource category is active" do
      category = FactoryBot.build(:resource_category, active: true)
      expect(category.inactive?).to be false
    end
  end

  describe "#to_s" do
    it "returns the resource category's name" do
      resource_category = ResourceCategory.new(name: "Shelter", active: true)
      expect(resource_category.to_s).to eq("Shelter")
    end
  end
end
