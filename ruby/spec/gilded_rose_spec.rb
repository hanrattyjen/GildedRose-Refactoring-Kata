# require File.join(File.dirname(__FILE__), 'gilded_rose')

require 'gilded_rose'

describe GildedRose do

  subject(:gilded_rose) { described_class.new(item) }
  let(:item) { Item.new("Item", 3, 6) }
  let(:low_quality_item) { Item.new("Crap", 2, 1) }

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
        2.times do
          GildedRose.new(items).update_quality
        end
        expect(items[0].quality).to eq 10
      end

      it 'does not lose it\'s Sellin value' do
        items = [sulfuras]
        2.times do
          GildedRose.new(items).update_quality
        end
        # GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 10
      end
    end

    context 'Once the sell by date has passed, Quality degrades twice as fast' do
      it 'Random item has a quality that will decrease twice as fast' do
        items = [item]
        4.times do
          GildedRose.new(items).update_quality # gives quality = 5, days=2
        end
        expect(items[0].quality).to eq 1
      end
    end

    context 'The quality of an item is never negative' do
      it 'will never have a negative quality' do
        items = [low_quality_item]
        2.times do
          GildedRose.new(items).update_quality
        end
        expect(items[0].quality).to eq 0
      end
    end
  end

end
