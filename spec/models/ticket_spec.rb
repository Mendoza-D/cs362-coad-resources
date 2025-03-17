require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before(:each) do
    Ticket.delete_all  # Ensure the tickets table is clean before each example
  end

  it 'exists' do
    ticket = Ticket.new
    expect(ticket).to be_a(Ticket)
  end

  it 'has attributes' do
    ticket = Ticket.new
    expect(ticket).to respond_to(:name)
    expect(ticket).to respond_to(:phone)
    expect(ticket).to respond_to(:description)
    expect(ticket).to respond_to(:closed)
    expect(ticket).to respond_to(:region_id)
    expect(ticket).to respond_to(:resource_category_id)
    expect(ticket).to respond_to(:organization_id)
  end

  it { should belong_to(:region) }
  it { should belong_to(:resource_category) }
  it { should belong_to(:organization).optional }

  describe "validations" do
    subject do
      region = FactoryBot.create(:region, name: "Some Region")
      resource_category = FactoryBot.create(:resource_category, active: true)
      # Let the factory assign a unique name using its sequence.
      FactoryBot.build(:ticket, phone: "2125551212", region: region, resource_category: resource_category)
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:region_id) }
    it { should validate_presence_of(:resource_category_id) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_length_of(:description).is_at_most(1020).on(:create) }

    it "starts with no tickets" do
      expect(Ticket.count).to eq(0)
    end
  end

  describe ".closed" do
    it "returns only tickets that are closed" do
      Ticket.delete_all
      expect(Ticket.count).to eq(0)

      # Generate highly unique names using Time.now.to_f and SecureRandom.hex.
      closed_name = "UniqueClosedTicket_#{Time.now.to_f}_#{SecureRandom.hex(8)}"
      open_name   = "UniqueOpenTicket_#{Time.now.to_f}_#{SecureRandom.hex(8)}"
      
      closed_ticket = FactoryBot.create(:ticket, name: closed_name, closed: true)
      open_ticket   = FactoryBot.create(:ticket, name: open_name, closed: false)

      expect(Ticket.count).to eq(2)
      expect(Ticket.closed).to include(closed_ticket)
      expect(Ticket.closed).not_to include(open_ticket)
    end
  end

  describe "#open?" do
    it "returns true if the ticket is not closed" do
      ticket = FactoryBot.build(:ticket, closed: false, phone: "2125551212")
      expect(ticket.open?).to be true
    end
  end

  describe "#captured?" do
    it "returns true if the ticket has an organization assigned" do
      org = FactoryBot.create(:organization,
                                email: "org@example.com",
                                name: "Org #{SecureRandom.hex(4)}",
                                phone: "2125551212",
                                status: "submitted",
                                primary_name: "Pri",
                                secondary_name: "Sec",
                                secondary_phone: "2125551212")
      ticket = FactoryBot.build(:ticket, organization: org, phone: "2125551212")
      expect(ticket.captured?).to be true
    end
  end

  describe "#to_s" do
    it "returns a string representation of the ticket" do
      ticket = FactoryBot.build(:ticket, closed: false, phone: "2125551212")
      ticket.id = 101  # Simulate an assigned id
      expect(ticket.to_s).to eq("Ticket 101")
    end
  end
end
