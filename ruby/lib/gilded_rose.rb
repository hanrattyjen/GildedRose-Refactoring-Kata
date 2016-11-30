require 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.quality > 50
        fail "Quality maximum has been reached"
      elsif item.quality < 0
        fail "Quality minimum has been reached"
      else
        item.sell_in -= 1
        case item.name
        when "Aged Brie"
          item.sell_in >= 0 ? item.quality += 1 : item.quality
        when "Sulfuras, Hand of Ragnaros"
          item.quality
          item.sell_in += 1
        when "Conjured"
          item.quality -= 2
        when "Backstage passes to a TAFKAL80ETC concert"
          if item.sell_in > 10
            item.quality += 1
          elsif item.sell_in <= 10 && item.sell_in > 5
            item.quality += 2
          elsif item.sell_in <= 5 && item.sell_in >= 0
            item.quality += 3
          elsif item.sell_in < 0
            item.quality = 0
          end
        else
          item.sell_in >= 0 ? item.quality -= 1 : item.quality -= 2
        end
      end
    end
  end
end
