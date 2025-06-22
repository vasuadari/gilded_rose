class GildedRose
  module ItemFactory
    def self.create_updatable_item(item)
      is_conjured = item.name.include?(ItemNames::CONJURED)
      # Since existing also could be conjured, we need to wrap
      # updatable item specific class also with Conjured decorator
      item_name = item.name.gsub('Conjured ', '')

      updatable_item =
        case item_name
        when ItemNames::AGED_BRIE
          Items::AgedBrie.new(item)
        when ItemNames::BACKSTAGE_PASSES
          Items::BackstagePasses.new(item)
        when ItemNames::SULFURAS
          Items::Sulfuras.new(item)
        else
          Items::UpdatableItem.new(item)
        end

      if is_conjured
        Items::ConjuredDecorator.new(updatable_item)
      else
        updatable_item
      end
    end
  end
end
