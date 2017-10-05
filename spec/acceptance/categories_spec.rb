require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Categories for Student" do
  let!(:category) { create :category }
  let(:response_json) do
    {
      data: [
        {
          name: 'English',
          is_default: false,
          id: category.id
        }
      ]
    }.to_json
  end

  get "/categories" do
    example "Listing Categories" do
      do_request

      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end

  get "/categories/:id" do
    parameter :id, 'ID of category', required: true

    let(:category) { create :category }
    let(:id) { category.id }
    let!(:flash_card) { create :flash_card, category: category }
    let(:response_json) do
      {
        data: {
          name: 'English',
          is_default: false,
          flash_card_ids: [flash_card.id]
        }
      }.to_json
    end

    example "Show Category and returns requested cards from that category" do
      do_request

      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end
end
