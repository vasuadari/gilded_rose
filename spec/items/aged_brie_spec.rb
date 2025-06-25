require 'spec_helper'

RSpec.describe GildedRose::Items::AgedBrie do
  describe '#calculate_quality_change' do
    it 'returns change as 1 when sell_in is above 0' do
      item = Item.new('eggs', 0, 1)
      updatable_item = GildedRose::Items::AgedBrie.new(item)

      expect(updatable_item.calculate_quality_change()).to eq 1
    end

    it 'returns change as 2 when sell_in is below 0' do
      item = Item.new('eggs', -1, 1)
      updatable_item = GildedRose::Items::AgedBrie.new(item)

      expect(updatable_item.calculate_quality_change()).to eq 2
    end

    it 'raises exception when sell_in is nil' do
      item = Item.new('eggs', nil, 1)
      updatable_item = GildedRose::Items::AgedBrie.new(item)

      expect { updatable_item.calculate_quality_change() }.to(
        raise_error(NoMethodError)
      )
    end
  end

  describe '#update' do
    it 'updates items sell_in and increases quality by once' do
      item = Item.new('eggs', 1, 1)
      updatable_item = GildedRose::Items::AgedBrie.new(item)

      updatable_item.update()

      expect(item.quality).to eq 2
      expect(item.sell_in).to eq 0
    end

    it 'updates items sell_in and increases quality by twice' do
      item = Item.new('eggs', 0, 1)
      updatable_item = GildedRose::Items::AgedBrie.new(item)

      updatable_item.update()

      expect(item.quality).to eq 3
      expect(item.sell_in).to eq -1
    end
  end

  describe '#age_item' do
    it 'only reduces sell_in by 1' do
      item = Item.new('eggs', 0, 1)
      updatable_item = GildedRose::Items::AgedBrie.new(item)

      updatable_item.age_item()

      expect(item.sell_in).to eq -1
      expect(item.quality).to eq 1
    end
  end
end
