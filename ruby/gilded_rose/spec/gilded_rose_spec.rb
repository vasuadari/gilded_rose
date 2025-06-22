require 'spec_helper'

RSpec.describe GildedRose do
  let(:sulfuras) { 'Sulfuras, Hand of Ragnaros' }
  let(:backstage_passes) { 'Backstage passes to a TAFKAL80ETC concert' }

  describe '#update_quality' do
    it 'does not change the name and quality' do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()

      expect(items[0].name).to eq 'foo'
      expect(items[0].quality).to eq 0
    end

    context 'quality is always positive' do
      it 'when sell_in is already zero' do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()

        expect(items[0].name).to eq 'foo'
        expect(items[0].quality).to eq 0
      end

      it 'when sell_in is negative' do
        items = [Item.new("foo", -1, 0)]
        GildedRose.new(items).update_quality()

        expect(items[0].name).to eq 'foo'
        expect(items[0].quality).to eq 0
      end

      it 'quality reduces by 1' do
        items = [Item.new("eggs", -1, 1)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 0
      end
    end

    context 'sell_in is below zero' do
      it 'quality reduces by 2 other than Aged Brie & Sulfuras' do
        items = [Item.new("eggs", -1, 40)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 38
      end

      it 'quality stays same fo sulfuras' do
        items = [Item.new(sulfuras, -1, 40)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 80
      end

      it 'quality increases by 2 for Aged Brie' do
        items = [Item.new('Aged Brie', -1, 40)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 42
      end
    end

    context 'sell_in is positive' do
      it 'sell_in decreases by 1 for Aged Brie' do
        items = [Item.new('Aged Brie', 1, 40)]

        GildedRose.new(items).update_quality()

        expect(items[0].sell_in).to eq 0
      end

      it 'sell_in decreases by 1 for Backstage passes' do
        items = [Item.new(backstage_passes, 1, 40)]

        GildedRose.new(items).update_quality()

        expect(items[0].sell_in).to eq 0
      end

      it 'sell_in stays same for Sulfuras' do
        items = [Item.new(sulfuras, 1, 40)]

        GildedRose.new(items).update_quality()

        expect(items[0].sell_in).to eq 1
      end

      it 'sell_in reduces by 1 for other item' do
        items = [Item.new('eggs', 1, 40)]

        GildedRose.new(items).update_quality()

        expect(items[0].sell_in).to eq 0
      end
    end

    context 'quality above zero' do
      it 'reduces quality by 1 other than Aged brie' do
        items = [Item.new("eggs", 10, 10)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 9
      end

      it 'reduces quality by 1 other than Backstage passes to a TAFKAL80ETC concert item' do
        items = [Item.new("eggs", 10, 10)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 9
      end

      it 'does not reduce quality for Sulfuras, Hand of Ragnaros item' do
        items = [Item.new(sulfuras, 0, 1)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 80
      end
    end

    context 'for Aged Brie' do
      it 'quality increases by 2 when less 50' do
        items = [Item.new("Aged Brie", 0, 1)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 3
      end

      it 'quality stays same if 50' do
        items = [Item.new("Aged Brie", 0, 50)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 50
      end
    end

    context 'for Backstage passes to a TAFKAL80ETC concert' do
      it 'quality becomes zero after concert' do
        items = [Item.new(backstage_passes, 0, 50)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 0
      end

      it 'does not increase quality if its above 50 when sell_in is above than 10' do
        items = [Item.new(backstage_passes, 11, 50)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 50
      end

      it 'does not increase quality if its above 50 when sell_in is less than 5' do
        items = [Item.new(backstage_passes, 4, 50)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 50
      end

      it 'increase quality by 2 when it is less than 50 and sell_in is less than 10' do
        items = [Item.new(backstage_passes, 9, 0)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 2
      end

      it 'increase quality by 3 when it is less than 50 and sell_in is less than 5' do
        items = [Item.new(backstage_passes, 4, 1)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 4
      end
    end

    context 'conjured' do
      it 'quality reduces twice as fast for conjured item' do
        items = [Item.new('Conjured eggs', 1, 50)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 48
      end
    end
  end
end
