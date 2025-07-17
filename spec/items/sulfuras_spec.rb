require 'spec_helper'

RSpec.describe GildedRose::Items::Sulfuras do
  describe '#calculate_quality_change' do
    it 'returns change always nil' do
      item = Item.new('eggs', -1, 50)
      updatable_item = GildedRose::Items::Sulfuras.new(item)

      expect(updatable_item.calculate_quality_change()).to be_nil

      item.quality = 30
      expect(updatable_item.calculate_quality_change()).to be_nil

      item.quality = 4
      expect(updatable_item.calculate_quality_change()).to be_nil

      item.quality = 0
      expect(updatable_item.calculate_quality_change()).to be_nil
    end

    it 'does not raises exception when sell_in is nil' do
      item = Item.new('eggs', nil, 1)
      updatable_item = GildedRose::Items::Sulfuras.new(item)

      expect { updatable_item.calculate_quality_change() }.not_to(raise_error)
    end
  end

  describe '#update' do
    it 'sell_in stays same and quality stays at 80' do
      item = Item.new('eggs', 11, 1)
      updatable_item = GildedRose::Items::Sulfuras.new(item)

      expect(updatable_item.update()).to be_nil

      expect(item.quality).to eq 80
      expect(item.sell_in).to eq 11
    end
  end

  describe '#age_item' do
    it 'only reduces sell_in by 1' do
      item = Item.new('eggs', 0, 1)
      updatable_item = GildedRose::Items::Sulfuras.new(item)

      updatable_item.age_item()

      expect(item.sell_in).to eq 0
      expect(item.quality).to eq 80
    end
  end
end
