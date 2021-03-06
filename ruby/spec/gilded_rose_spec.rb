require 'gilded_rose'

describe GildedRose do

  subject(:gilded_rose) { described_class.new(item) }

  describe '#update_quality' do
    let(:item) { Item.new("Item", 3, 8) }

    it 'does not change the name' do
      items = [item]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Item'
    end

    context 'Once the sell by date has passed, Quality degrades twice as fast' do
      it 'Random item has a quality that will decrease twice as fast' do
        items = [item]
        5.times do
          GildedRose.new(items).update_quality # gives quality = 5, days=2
        end
        expect(items[0].quality).to eq 1
      end
    end

    context 'The quality of an item is never more than 50' do
      let(:amazing_item) { Item.new("Amazing", 3, 52) }

      describe 'Amazing items' do
        it 'cannnot have quality more than 50' do
          items = [amazing_item]
          expect{GildedRose.new(items).update_quality}.to raise_error "Quality maximum has been reached"
        end
      end
    end

    context 'The quality of an item is never negative' do
      let(:low_quality_item) { Item.new("Crap", 2, 1) }

      it 'will never have a negative quality' do
        items = [low_quality_item]
        2.times do
          GildedRose.new(items).update_quality
        end
        expect{ GildedRose.new(items).update_quality }.to raise_error "Quality minimum has been reached"
      end
    end

    context 'Aged Brie increases in quality the older it gets' do
      let(:aged_brie) { Item.new("Aged Brie", 2, 2) }

      describe 'Aged Brie' do
        it 'increases in quality' do
          items = [aged_brie]
          2.times do
            GildedRose.new(items).update_quality
          end
          expect(items[0].quality).to eq 4
        end
      end
    end

    context 'Sulfuras never has to be sold or decreases in Quality' do
      let(:sulfuras) { Item.new("Sulfuras, Hand of Ragnaros", 10, 10) }

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
    end

    context 'Backstage passes increase in quality' do
      describe 'Backstage passes' do
        let(:backstage) { Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 6) }

        it 'increases in value as Sellin value approaches' do
          items = [backstage]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 7
        end

        it 'increases in value by 2 when there are <= 10 Sellin days left' do
          items = [backstage]
          4.times do
            GildedRose.new(items).update_quality
          end
          expect(items[0].quality).to eq 13
        end

        it 'increases in value by 3 when there are <= 5 Sellin days left' do
          items = [backstage]
          8.times do
            GildedRose.new(items).update_quality
          end
          expect(items[0].quality).to eq 23
        end

        it 'has a quality that drops to zero after the concert' do
          items = [backstage]
          14.times do
            GildedRose.new(items).update_quality
          end
          expect(items[0].quality).to eq 0
        end
      end
    end

    context "Conjured items decrease in quality twice as fast as normal ones" do
      describe "Conjured items" do
        let(:conjured) { Item.new("Conjured", 3, 8) }

        it 'has a quality that decreases twice as fast as normal items' do
          items = [conjured]
          2.times do
            GildedRose.new(items).update_quality
          end
          expect(items[0].quality).to eq 4
        end
      end
    end

    context "Added many items to a list" do
      describe "Many items" do
        let(:aged_brie) { Item.new("Aged Brie", 2, 2) }
        let(:conjured) { Item.new("Conjured", 3, 8) }
        let(:item) { Item.new("Item", 3, 8) }

        it 'can show all of the items' do
          items = [aged_brie, conjured, item]
          GildedRose.new(items).update_quality
          expect(items[1].quality).to eq 6
        end
      end
    end

  end

end
