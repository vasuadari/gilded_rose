class GildedRose
  module Items
    class UpdatableItem
      attr_accessor :item

      def initialize(item)
        @item = item
      end

      def calculate_quality_change
        change = -1
        change = -2 if @item.sell_in < 0
        change
      end

      def age_item
        self.item.sell_in -= 1
      end

      def update
        age_item()

        QualityManager.reduce_quality(self.item, calculate_quality_change())
      end
    end
  end
end
