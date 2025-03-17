require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  include Devise::Test::ControllerHelpers

  context "when not logged in" do
    it "redirects to sign-in" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when logged in as an admin" do
    let(:admin) { FactoryBot.create(:user, role: :admin) }
    before { sign_in admin }

    it "renders the dashboard with status options" do
      get :index
      expect(response).to be_successful
      expect(assigns(:status_options)).to include("Open", "Captured", "Closed")
    end
  end

  context "when logged in as an approved organization user" do
    let(:org_user) { FactoryBot.create(:user, role: :organization) }
    before { sign_in org_user }

    it "renders the dashboard with organization status options" do
      get :index
      expect(response).to be_successful
      # Depending on your logic, check for organization dashboard options
      expect(assigns(:status_options)).to include("Open", "My Captured", "My Closed")
    end
  end
end
