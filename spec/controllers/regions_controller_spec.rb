require 'rails_helper'

RSpec.describe RegionsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:region) { FactoryBot.create(:region, name: "Test Region") }

  context "when not logged in" do
    describe "GET #index" do
      it "redirects to the sign in page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #show" do
      it "redirects to the sign in page" do
        get :show, params: { id: region.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "when logged in as an admin" do
    let(:admin) { FactoryBot.create(:user, role: :admin, email: "admin@example.com") }
    before { sign_in admin }

    describe "GET #index" do
      it "renders the index template" do
        get :index
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
    end

    describe "GET #show" do
      it "renders the show template" do
        get :show, params: { id: region.id }
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end

    describe "GET #new" do
      it "renders the new template" do
        get :new
        expect(response).to be_successful
        expect(response).to render_template(:new)
      end
    end

    describe "POST #create" do
      it "creates a new region and redirects to its show page" do
        region_params = { name: "New Region" }
        expect {
          post :create, params: { region: region_params }
        }.to change(Region, :count).by(1)
        expect(response).to redirect_to(region_path(Region.last))
      end
    end

  end
end
