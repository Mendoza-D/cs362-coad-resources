require 'rails_helper'

RSpec.describe DashboardHelper, type: :helper do
  describe "#dashboard_for" do
    it "returns 'admin_dashboard' when the user is an admin" do
      user = double("User", admin?: true)
      expect(helper.dashboard_for(user)).to eq("admin_dashboard")
    end

    it "returns 'organization_submitted_dashboard' when the user's organization is submitted" do
      organization = double("Organization", submitted?: true, approved?: false)
      user = double("User", admin?: false, organization: organization)
      expect(helper.dashboard_for(user)).to eq("organization_submitted_dashboard")
    end

    it "returns 'organization_approved_dashboard' when the user's organization is approved" do
      organization = double("Organization", submitted?: false, approved?: true)
      user = double("User", admin?: false, organization: organization)
      expect(helper.dashboard_for(user)).to eq("organization_approved_dashboard")
    end

    it "returns 'create_application_dashboard' when the user has no organization" do
      user = double("User", admin?: false, organization: nil)
      expect(helper.dashboard_for(user)).to eq("create_application_dashboard")
    end
  end
end
