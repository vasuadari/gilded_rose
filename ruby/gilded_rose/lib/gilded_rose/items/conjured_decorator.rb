class GildedRose
  module Items
    class ConjuredDecorator < ItemDecorator
      def calculate_quality_change
        quality_change = @wrapped_item.calculate_quality_change

        # For sulfuras, Quality always stays the same.
        return if quality_change.nil?

        quality_change && quality_change > 0 ? quality_change : quality_change * 2
      end
    end
  end
end
