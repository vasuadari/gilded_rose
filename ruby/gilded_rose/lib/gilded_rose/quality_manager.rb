class GildedRose
  module QualityManager
    def self.reduce_quality(item, quality_change)
      new_quality = item.quality + quality_change

      item.quality = [[new_quality, MIN_QUALITY].max, MAX_QUALITY].min
    end
  end
end
