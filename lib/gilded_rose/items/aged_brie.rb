class GildedRose
  module Items
    class AgedBrie < UpdatableItem
      def calculate_quality_change
        change = 1
        change = 2 if @item.sell_in < 0
        change
      end
    end
  end
end

