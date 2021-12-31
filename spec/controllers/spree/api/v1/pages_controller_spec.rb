require 'spec_helper'
require 'spree/testing_support'
# require 'spree_dev_tools'

module Spree
  describe Api::V1::PagesController, type: :controller do
    render_views

    # 8.00 it's a example value. Use any other value that your wish!
    let!(:page) { create(:page, slug: "home") }
    let!(:user) { create(:user) }

    before do
      # Mock API autentication using a "spree_api_key"
      stub_authentication!
    end

    it 'retrieves a list of pages' do
      api_get :index
      expect(json_response.size).to eq(1)
      expect(json_response.first["slug"].to_f).to eq(page.slug)
    end
  end
end