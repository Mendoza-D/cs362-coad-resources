require 'rails_helper'

RSpec.describe Ticket, type: :model do
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


  it {should belong_to(:region)}
  it {should belong_to(:resource_category)}
  it {should belong_to(:organization).optional}
end
