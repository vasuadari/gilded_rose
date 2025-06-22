class GildedRose
  module Items
    class AgedBrie < UpdatableItem
      def update
        sell_in = @item.sell_in
        quality = @item.quality

        sell_in -= 1

        quality += 1 if quality < 50
        quality += 1 if sell_in < 0 && quality < 50

        @item.quality = quality
        @item.sell_in = sell_in
      end
    end
  end
end

