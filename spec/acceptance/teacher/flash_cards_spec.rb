require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "FlashCards for Teacher" do
  get 'teacher/flash_cards' do
    let!(:flash_card) { create :flash_card }
    let(:response_json) { [{face: '1+1', back: '=2'}].to_json }

    example_request "returns all created cards" do
      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end

  get 'teacher/flash_cards/:id' do
    parameter :id, 'ID of flash card', required: true
    let(:flash_card) { create :flash_card }
    let(:response_json) do
      {face: '1+1', back: '=2'}.to_json
    end
    let(:id) { flash_card.id }

    example_request "returns requested card" do
      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end

  post 'teacher/flash_cards' do
    parameter :face, 'Front side of card', scope: :flash_card
    parameter :back, 'Back side of card', scope: :flash_card

    let(:params) do
      {
        flash_card:
          {
            face: 'Face',
            back: 'Back'
          }
      }
    end

    let(:response_json) do
      {face: 'Face', back: 'Back'}.to_json
    end

    before do
      create :category, is_default: true
    end

    example "creates and returns card" do
      do_request(params)
      expect(status).to eq 201
      expect(response_body).to eq response_json
    end
  end

  delete 'teacher/flash_cards/:id' do
    parameter :id, 'ID of flash card', required: true
    let(:flash_card) { create :flash_card }
    let!(:id) { flash_card.id }

    example "deletes requested card" do
      expect{do_request}.to change{FlashCard.count}.from(1).to(0)
      expect(status).to eq 200
    end
  end
end