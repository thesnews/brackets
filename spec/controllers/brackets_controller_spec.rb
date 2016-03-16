require 'rails_helper'

RSpec.describe BracketsController, type: :controller do
  before(:all) do
    @tournament = FactoryGirl.create(:tournament,
                                     start_date: DateTime.now + 1.day)
    @tournament_uid_slug = FactoryGirl.create(:tournament,
                                              start_date: DateTime.now + 1.day)
    @tournament_started = FactoryGirl.create(:tournament,
                                             start_date: DateTime.now - 1.day)
  end

  after(:all) do
    Tournament.destroy_all
  end

  describe "GET #new" do
    it "returns http success if tournament hasn't started" do
      get :new, tournament_id: @tournament
      expect(response).to have_http_status(:success)
    end

    it "returns http success slug is duplicate" do
      get :new, tournament_id: @tournament_uid_slug
      expect(response).to have_http_status(:success)
    end

    it "returns http redirect if tournament started" do
      get :new, tournament_id: @tournament_started
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to tournament_path(@tournament_started)
    end
  end
end
