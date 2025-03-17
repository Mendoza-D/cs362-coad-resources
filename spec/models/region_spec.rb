require 'rails_helper'

RSpec.describe Region, type: :model do
  it "exists" do
    region = Region.new
    expect(region).to be_a(Region)
  end

  it 'has attributes' do
    region = Region.new
    expect(region).to respond_to(:name)
  end

  it { should have_many(:tickets) }

  describe "validations" do
    subject { Region.new(name: "Test Region") }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "#to_s" do
    it "returns the region's name" do
      region = Region.new(name: "Mt. Hood")
      expect(region.to_s).to eq("Mt. Hood")
    end
  end

  describe ".unspecified" do
    it "returns a region with the name 'Unspecified'" do
      region = Region.unspecified
      expect(region.name).to eq("Unspecified")
    end
  end
end
