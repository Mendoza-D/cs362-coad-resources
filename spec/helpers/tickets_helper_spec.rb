require 'rails_helper'

RSpec.describe TicketsHelper, type: :helper do
  describe "#format_phone_number" do
    it "normalizes the phone number to E.164 format" do
      input_number = "5551234567"
      normalized = helper.format_phone_number(input_number)
      expect(normalized).to eq("+15551234567")
    end
  end
end
