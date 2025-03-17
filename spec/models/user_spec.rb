require 'rails_helper'

RSpec.describe User, type: :model do
  it 'exists' do
    user = User.new
    expect(user).to be_a(User)
  end

  it 'has attributes' do
    user = User.new
    expect(user).to respond_to(:email)
    expect(user).to respond_to(:encrypted_password)
    expect(user).to respond_to(:role)
    expect(user).to respond_to(:organization_id)
  end

  it { should belong_to(:organization).optional(true) }

  describe "validations" do
    subject { FactoryBot.build(:user, email: "user@example.com", password: "password123") }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
    it { should allow_value("user@example.com").for(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password).on(:create) }
    it { should validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create) }
  end

  describe "#to_s" do
    it "returns the user's email" do
      user = FactoryBot.build(:user, email: "user@example.com", password: "password123")
      expect(user.to_s).to eq("user@example.com")
    end
  end
end
