require 'gilded_rose/item'
require 'delegate'

require 'gilded_rose/items/updatable_item'
require 'gilded_rose/items/item_decorator'
require 'gilded_rose/items/conjured_decorator'
require 'gilded_rose/items/aged_brie'
require 'gilded_rose/items/backstage_passes'
require 'gilded_rose/items/sulfuras'
require 'gilded_rose/item_factory'
require 'gilded_rose/quality_manager'

class GildedRose
  VERSION = "1.0.0"

  class Error < StandardError; end

  module ItemNames
    AGED_BRIE = 'Aged Brie'
    BACKSTAGE_PASSES = 'Backstage passes to a TAFKAL80ETC concert'
    SULFURAS = 'Sulfuras, Hand of Ragnaros'
    CONJURED = 'Conjured'
  end

  MIN_QUALITY = 0
  MAX_QUALITY = 50

  module DefaultQuality
    SULFURAS = 80
  end

  def initialize(items)
    @items_to_update = items.map do |item|
      ItemFactory.create_updatable_item(item)
    end
  end

  def update_quality
    @items_to_update.each do |item_to_update|
      item_to_update.update()
    end
  end
end
