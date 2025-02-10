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
  end

  

  #it "has a name" do
    #region = Region.new
    #expect(region).to respond_to(:name)
  #end

  #it "has a string representation that is its name" do
    #name = 'Mt. Hood'
    #region = Region.new(name: name)
    #result = region.to_s
  #end
#end
