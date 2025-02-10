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
end

