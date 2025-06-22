require 'gilded_rose/item'

class GildedRose
  VERSION = "1.0.0"

  class Error < StandardError; end

  module ItemNames
    AGED_BRIE = 'Aged Brie'
    BACKSTAGE_PASSES = 'Backstage passes to a TAFKAL80ETC concert'
    SULFURAS = 'Sulfuras, Hand of Ragnaros'
  end

  module DefaultQuality
    SULFURAS = 80
  end

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do | item|
      updatable_item =
        case item.name
        when ItemNames::AGED_BRIE
          GildedRose::Items::AgedBrie.new(item)
        when ItemNames::BACKSTAGE_PASSES
          GildedRose::Items::BackstagePasses.new(item)
        when ItemNames::SULFURAS
          GildedRose::Items::Sulfuras.new(item)
        else
          GildedRose::Items::UpdatableItem.new(item)
        end

      updatable_item.update()
    end
  end
end

require 'gilded_rose/items/updatable_item'
require 'gilded_rose/items/aged_brie'
require 'gilded_rose/items/backstage_passes'
require 'gilded_rose/items/sulfuras'
