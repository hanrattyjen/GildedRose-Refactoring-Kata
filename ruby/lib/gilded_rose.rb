require 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      # Aged Brie and backstage passes increase in quality the older it gets
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          # Sulfuras legendary item, never has to be sold or decrease in quality
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          # Backstage passes increases in quality as its Sellin value approaches
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            # Quality increases by 2 when < 11 days left
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                # Quality increases by 3 when there are < 6 days left
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0 # i.e sell by date has pased - quality degrades twice as fast
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          # if item.name = "Aged Brie"
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end
end
