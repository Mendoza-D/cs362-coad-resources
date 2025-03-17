require 'rails_helper'

RSpec.describe Organization, type: :model do
  # Basic existence and attribute tests
  it 'exists' do
    organization = Organization.new
    expect(organization).to be_a(Organization)
  end

  it 'has attributes' do
    organization = Organization.new
    expect(organization).to respond_to(:name)
    expect(organization).to respond_to(:email)
    expect(organization).to respond_to(:phone)
    expect(organization).to respond_to(:status)
    expect(organization).to respond_to(:primary_name)
    expect(organization).to respond_to(:secondary_name)
    expect(organization).to respond_to(:secondary_phone)
    expect(organization).to respond_to(:description)
  end

  it 'has non-persistent attributes' do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_one)
    expect(organization).to respond_to(:agreement_two)
    expect(organization).to respond_to(:agreement_three)
    expect(organization).to respond_to(:agreement_four)
    expect(organization).to respond_to(:agreement_five)
    expect(organization).to respond_to(:agreement_six)
    expect(organization).to respond_to(:agreement_seven)
    expect(organization).to respond_to(:agreement_eight)
  end

  it { should have_many(:users) }
  it { should have_many(:tickets) }
  it { should have_and_belong_to_many(:resource_categories) }

  # Validation tests
  describe "validations" do
    subject do
      Organization.new(
        email: "test@example.com",
        name: "Test Org",
        phone: "1234567890",
        status: "submitted",
        primary_name: "Primary",
        secondary_name: "Secondary",
        secondary_phone: "0987654321"
      )
    end

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:primary_name) }
    it { should validate_presence_of(:secondary_name) }
    it { should validate_presence_of(:secondary_phone) }
    it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_length_of(:description).is_at_most(1020).on(:create) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  # Callback and method tests
  describe "#set_default_status" do
    it "sets the default status to 'submitted' if none is provided" do
      org = Organization.new(
        email: "another@example.com",
        name: "Another Organization",
        phone: "555-555-5555",
        primary_name: "Pri",
        secondary_name: "Sec",
        secondary_phone: "0987654321"
      )
      org.save
      expect(org.status).to eq("submitted")
    end
  end

  describe "#to_s" do
    it "returns the organization's name" do
      org = Organization.new(
        name: "My Organization",
        email: "test@example.com",
        phone: "1234567890",
        status: "submitted",
        primary_name: "Pri",
        secondary_name: "Sec",
        secondary_phone: "0987654321"
      )
      expect(org.to_s).to eq("My Organization")
    end
  end
end
