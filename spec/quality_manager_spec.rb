require 'spec_helper'

RSpec.describe GildedRose::QualityManager do
  describe '.reduce_quality' do
    it 'reduce by given quality change' do
      item = Item.new('eggs', 0, 1)
      GildedRose::QualityManager.reduce_quality(
        item, -1
      )

      expect(item.quality).to eq 0
    end

    it 'quality always stays positive' do
      item = Item.new('eggs', 0, 0)
      GildedRose::QualityManager.reduce_quality(
        item, -1
      )

      expect(item.quality).to eq 0
    end

    it 'quality always stays at 50' do
      item = Item.new('eggs', 0, 50)
      GildedRose::QualityManager.reduce_quality(
        item, 1
      )

      expect(item.quality).to eq 50
    end
  end
end
