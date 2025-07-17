class GildedRose
  module Items
    class ItemDecorator < SimpleDelegator
      attr_reader :wrapped_item

      def initialize(wrapped_item)
        super(wrapped_item)
        @wrapped_item = wrapped_item
      end

      def update
        age_item()

        quality_change = calculate_quality_change()
        QualityManager.reduce_quality(self.item, quality_change) if quality_change
      end
    end
  end
end
