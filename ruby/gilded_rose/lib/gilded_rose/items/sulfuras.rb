class GildedRose
  module Items
    class Sulfuras < UpdatableItem
      def initialize(item)
        super(item)

        @item.quality = GildedRose::DefaultQuality::SULFURAS
      end


      def calculate_quality_change
        # Since, update is skipped this can be left empty
      end

      def update
        # Sulfuras, Hand of Ragnaros never has to be sold or decreases in Quality
        # Its quality is always 80, and sell_in does not change
        # So, its update method is intentionally empty.
      end
    end
  end
end
