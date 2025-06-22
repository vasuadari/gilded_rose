class GildedRose
  module Items
    class UpdatableItem
      def initialize(item)
        @item = item
      end

      def update
        sell_in = @item.sell_in
        quality = @item.quality

        sell_in -= 1

        quality -= 1 if quality > 0

        quality -= 1 if sell_in < 0 && quality > 0

        @item.quality = quality
        @item.sell_in = sell_in
      end
    end
  end
end
