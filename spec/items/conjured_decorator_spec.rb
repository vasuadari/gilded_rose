require 'spec_helper'

RSpec.describe GildedRose::Items::ConjuredDecorator do
  let(:backstage_passes_name) { 'Conjured Backstage passes to a TAFKAL80ETC concert' }

  describe '#calculate_quality_change' do
    it 'returns negative quality twice its value for conjured backstage passes' do
      item = Item.new(backstage_passes_name, -1, 50)
      conjured_item = GildedRose::ItemFactory.create_updatable_item(item)

      expect(conjured_item.calculate_quality_change()).to eq -100
    end

    it 'conjured aged brie increase at the same rate' do
      item = Item.new('Conjured Aged Brie', -1, 50)
      conjured_item = GildedRose::ItemFactory.create_updatable_item(item)

      expect(conjured_item.calculate_quality_change()).to eq 2
    end

    it 'returns nil for conjured sulfuras' do
      item = Item.new('Conjured Sulfuras, Hand of Ragnaros', -1, 50)
      conjured_item = GildedRose::ItemFactory.create_updatable_item(item)

      expect(conjured_item.calculate_quality_change()).to be_nil
    end

    it 'returns nil for conjured other items' do
      item = Item.new('Conjured foobar', 0, 50)
      conjured_item = GildedRose::ItemFactory.create_updatable_item(item)

      expect(conjured_item.calculate_quality_change()).to eq -2
    end
  end

  describe '#update' do
    it 'reduces quality by twice its value for conjured backstage passes' do
      item = Item.new(backstage_passes_name, -1, 50)
      conjured_item = GildedRose::ItemFactory.create_updatable_item(item)

      conjured_item.update()

      expect(item.quality).to eq 0
    end

    it 'conjured aged brie increase at the same rate' do
      item = Item.new('Conjured Aged Brie', -1, 50)
      conjured_item = GildedRose::ItemFactory.create_updatable_item(item)

      conjured_item.update()

      expect(item.quality).to eq 50
    end

    it 'quality stays at 80 for conjured sulfuras' do
      item = Item.new('Conjured Sulfuras, Hand of Ragnaros', -1, 50)
      conjured_item = GildedRose::ItemFactory.create_updatable_item(item)

      conjured_item.update()

      expect(item.quality).to eq 80
    end

    it 'reduces quality by 2 for conjured other items' do
      item = Item.new('Conjured foobar', 1, 50)
      conjured_item = GildedRose::ItemFactory.create_updatable_item(item)

      conjured_item.update()

      expect(item.quality).to eq 48
    end

    it 'reduces quality by 4 for conjured other items when expired' do
      item = Item.new('Conjured foobar', 0, 50)
      conjured_item = GildedRose::ItemFactory.create_updatable_item(item)

      conjured_item.update()

      expect(item.quality).to eq 46
    end
  end
end
