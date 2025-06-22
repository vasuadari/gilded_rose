class GildedRose
  module Items
    class BackstagePasses < UpdatableItem
      def calculate_quality_change
        change = 1
        change = 2 if @item.sell_in < 10
        change = 3 if @item.sell_in < 5
        change = -@item.quality if @item.sell_in < 0
        change
      end
    end
  end
end
