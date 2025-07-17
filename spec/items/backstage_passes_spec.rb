require 'spec_helper'

RSpec.describe GildedRose::Items::BackstagePasses do
  describe '#calculate_quality_change' do
    it 'returns change as 3 when sell_in is between 0 and 5' do
      item = Item.new('eggs', 0, 1)
      updatable_item = GildedRose::Items::BackstagePasses.new(item)

      expect(updatable_item.calculate_quality_change()).to eq 3
    end

    it 'returns change as item quality to reduce when sell_in is below 0' do
      item = Item.new('eggs', -1, 50)
      updatable_item = GildedRose::Items::BackstagePasses.new(item)

      expect(updatable_item.calculate_quality_change()).to eq -50
    end

    it 'raises exception when sell_in is nil' do
      item = Item.new('eggs', nil, 1)
      updatable_item = GildedRose::Items::BackstagePasses.new(item)

      expect { updatable_item.calculate_quality_change() }.to(
        raise_error(NoMethodError)
      )
    end
  end

  describe '#update' do
    it 'updates items sell_in and increases quality by once' do
      item = Item.new('eggs', 11, 1)
      updatable_item = GildedRose::Items::BackstagePasses.new(item)

      updatable_item.update()

      expect(item.quality).to eq 2
      expect(item.sell_in).to eq 10
    end

    it 'updates items sell_in and increases quality by twice' do
      item = Item.new('eggs', 9, 1)
      updatable_item = GildedRose::Items::BackstagePasses.new(item)

      updatable_item.update()

      expect(item.quality).to eq 3
      expect(item.sell_in).to eq 8
    end

    it 'updates items sell_in and increases quality by thrice' do
      item = Item.new('eggs', 4, 1)
      updatable_item = GildedRose::Items::BackstagePasses.new(item)

      updatable_item.update()

      expect(item.quality).to eq 4
      expect(item.sell_in).to eq 3
    end
  end

  describe '#age_item' do
    it 'only reduces sell_in by 1' do
      item = Item.new('eggs', 0, 1)
      updatable_item = GildedRose::Items::BackstagePasses.new(item)

      updatable_item.age_item()

      expect(item.sell_in).to eq -1
      expect(item.quality).to eq 1
    end
  end
end
