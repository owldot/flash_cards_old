require 'rails_helper'

RSpec.describe DefaultStrategy do
  let(:category) { create :category }
  subject { described_class.new(flash_cards, 2) }

  describe '#cards' do

    context 'initially there are less than designed number of cards' do
      let(:flash_cards) { [create(:flash_card, category: category)] }

      it 'fetches 1 flash card only' do
        expect(subject.cards).to eq flash_cards
      end
    end

    context 'initially there are more than designed number of cards' do
      let(:flash_cards) { create_list(:flash_card, 3, category: category) }

      it 'fetches designed number of flash cards only' do
        expect(subject.cards.length).to eq 2
      end
    end
  end

end