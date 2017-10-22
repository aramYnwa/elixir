defmodule GildedRose do
  def update_quality(items) do
    for item <- items do
      item =
      if (item.name != "Aged Brie") and (item.name != "Backstage passes to a TAFKAL80ETC concert") do
        if (item.quality > 0) do
          if (item.name != "Sulfuras, Hand of Ragnaros") do
            %{item | quality: item.quality - 1}
          else
            item
          end
        else
          item
        end
      else
        if (item.quality < 50) do
          itemp = %{item | quality: item.quality + 1}
          if (itemp.name == "Backstage passes to a TAFKAL80ETC concert") do
            itemq =
              if (itemp.sell_in < 11) do
                if (itemp.quality < 50) do
                  %{itemp | quality: itemp.quality + 1}
                else
                  itemp
                end
              else
                itemp
              end
            if (itemq.sell_in < 6) do
              if (itemq.quality < 50) do
                %{itemq | quality: itemq.quality + 1}
              else
                itemq
              end
            else
              itemq
            end
          else
            itemp
          end
        else
          item
        end
      end
      item =
      if (item.name != "Sulfuras, Hand of Ragnaros") do
        %{item | sell_in: item.sell_in - 1}
      else
        item
      end
      item = 
      if (item.sell_in < 0) do
        if (item.name != "Aged Brie") do
          if (item.name != "Backstage passes to a TAFKAL80ETC concert") do
            if item.quality > 0 do
              if (item.name != "Sulfuras, Hand of Ragnaros") do
                %{item | quality: item.quality - 1}
              else
                item
              end
            else
              item
            end
          else
            %{item | quality: item.quality - item.quality}
          end
        else
          if (item.quality < 50) do
            %{item | quality: item.quality + 1}
          else
            item
          end
        end
      else
        item
      end
    end
  end
end