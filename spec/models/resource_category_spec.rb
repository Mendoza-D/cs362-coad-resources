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


  it {should have_and_belong_to_many(:organizations)}
  it {should have_many(:tickets)}
  end