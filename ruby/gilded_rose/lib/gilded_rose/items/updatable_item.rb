class GildedRose
  module Items
    class UpdatableItem
      def initialize(item)
        @item = item
      end

      def calculate_quality_change
        change = -1
        change = -2 if @item.sell_in < 0
        change
      end

      def update
        @item.sell_in -= 1

        quality_change = calculate_quality_change()

        new_quality = @item.quality + quality_change

        @item.quality = [[new_quality, 0].max, 50].min
      end
    end
  end
end
