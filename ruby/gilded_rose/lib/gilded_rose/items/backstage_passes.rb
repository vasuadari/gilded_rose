class GildedRose
  module Items
    class BackstagePasses < UpdatableItem
      def update
        sell_in = @item.sell_in
        quality = @item.quality

        sell_in -= 1

        if quality < 50
          quality += 1
          quality += 1 if sell_in < 10
          quality += 1 if sell_in < 5
        end

        quality -= quality if sell_in < 0

        @item.quality = quality
        @item.sell_in = sell_in
      end
    end
  end
end
