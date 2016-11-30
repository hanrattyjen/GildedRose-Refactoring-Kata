# require File.join(File.dirname(__FILE__), 'gilded_rose')

require 'gilded_rose'

describe GildedRose do

  subject(:gilded_rose) { described_class.new(item) }
  let(:item) { Item.new("Item", 1, 5) }
  let(:sulfuras) { Item.new("Sulfuras, Hand of Ragnaros", 10, 10) }

  describe '#update_quality' do
    it 'does not change the name' do
      items = [item]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Item'
    end

    describe 'Sulfuras' do
      it 'does not lose it\'s Quality' do
        items = [sulfuras]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 10
      end

      it 'does not lose it\'s Sellin value' do
        items = [sulfuras]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 10
      end
    end
  end

end
