require 'rails_helper'

RSpec.describe Organization, type: :model do
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
end



