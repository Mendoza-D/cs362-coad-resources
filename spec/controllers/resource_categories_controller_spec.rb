require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:resource_category) { FactoryBot.create(:resource_category) }

  context "when not logged in" do
    it "redirects index to sign-in" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects show to sign-in" do
      get :show, params: { id: resource_category.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when logged in as admin" do
    let(:admin) { FactoryBot.create(:user, role: :admin) }
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
        get :show, params: { id: resource_category.id }
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
      it "creates a new resource category and redirects to index" do
        rc_params = { name: "New Category" }
        expect {
          post :create, params: { resource_category: rc_params }
        }.to change(ResourceCategory, :count).by(1)
        expect(response).to redirect_to(resource_categories_path)
      end
    end

    # Add tests for edit, update, activate, deactivate, and destroy as needed.
  end
end
