require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  include Devise::Test::ControllerHelpers

  # For actions that require an approved organization or admin:
  let(:approved_org_user) do
    org = FactoryBot.create(:organization,
                              email: "org@example.com",
                              name: "Test Organization",
                              phone: "2125551212",
                              status: "submitted",  # Assuming submitted becomes approved via your workflow
                              primary_name: "Pri",
                              secondary_name: "Sec",
                              secondary_phone: "2125551212")
    # You might need to manually set the organization as approved if your system does so.
    FactoryBot.create(:user, role: :organization, organization: org)
  end

  let(:admin) { FactoryBot.create(:user, role: :admin) }

  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "creates a ticket and redirects when valid" do
      # You might need to adjust params to match your form.
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket_params = {
        name: "Test Ticket",
        phone: "2125551212",
        description: "Test description",
        region_id: region.id,
        resource_category_id: resource_category.id
      }
      post :create, params: { ticket: ticket_params }
      expect(response).to redirect_to(ticket_submitted_path)
    end
  end

  describe "GET #show" do
    context "when the current user is an approved organization user" do
      before { sign_in approved_org_user }

      it "renders the show template" do
        ticket = FactoryBot.create(:ticket)
        get :show, params: { id: ticket.id }
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end

    context "when the current user is an admin" do
      before { sign_in admin }

      it "renders the show template" do
        ticket = FactoryBot.create(:ticket)
        get :show, params: { id: ticket.id }
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end

    context "when the current user is neither approved organization nor admin" do
      let(:unapproved_user) { FactoryBot.create(:user, role: :organization, organization: nil) }
      before { sign_in unapproved_user }

      it "redirects to the dashboard" do
        ticket = FactoryBot.create(:ticket)
        get :show, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  # For capture, release, and close actions, you would need to stub TicketService methods.
  # For example:
  describe "POST #capture" do
    before { sign_in approved_org_user }

    it "redirects to dashboard with a success anchor when capture is successful" do
      allow(TicketService).to receive(:capture_ticket).and_return(:ok)
      ticket = FactoryBot.create(:ticket)
      post :capture, params: { id: ticket.id }
      expect(response).to redirect_to(dashboard_path + '#tickets:open')
    end
  end

  describe "DELETE #destroy" do
    before { sign_in admin }

    it "destroys the ticket and redirects" do
      ticket = FactoryBot.create(:ticket)
      expect {
        delete :destroy, params: { id: ticket.id }
      }.to change(Ticket, :count).by(-1)
      expect(response).to redirect_to(dashboard_path + '#tickets')
    end
  end
end
