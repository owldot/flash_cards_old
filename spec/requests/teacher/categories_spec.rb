require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET teacher/categories" do
    let!(:category) { create :category }
    let(:response_json) { [{name: 'English', is_default: false}].to_json }

    it "returns all created categories" do
      get teacher_categories_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq response_json
    end
  end

  describe "GET teacher/categories/:id" do
    let(:category) { create :category }
    let!(:flash_cards) { create :flash_card, category: category }
    let(:response_json) do
      {
        name: 'English',
        is_default: false,
        flash_cards: [{
          face: '1+1',
          back: '=2'
        }]
      }.to_json
    end

    it "returns requested cards from category" do
      get teacher_category_path(category)
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq response_json
    end
  end
  #
  # describe "POST teacher/flash_cards" do
  #   let(:params) do
  #     {
  #       flash_card:
  #         {
  #           face: 'Face',
  #           back: 'Back'
  #         }
  #     }
  #   end
  #
  #   before do
  #     create :category, is_default: true
  #   end
  #
  #   let(:response_json) do
  #     {face: 'Face', back: 'Back'}.to_json
  #   end
  #
  #   it "creates and returns card" do
  #     post teacher_flash_cards_path(params)
  #     expect(response).to have_http_status(:created)
  #     expect(response.body).to eq response_json
  #   end
  # end
  #
  # describe "DELETE teacher/flash_cards/:id" do
  #   let(:flash_card) { create :flash_card }
  #
  #   it "deletes requested card" do
  #     delete teacher_flash_card_path(flash_card)
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
end