defmodule GildedRoseTest do
  use ExUnit.Case

  test "At the end of each day our system lowers both values for every item" do
    item = %Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20}
    [updated_item] = GildedRose.update_quality([item])
    assert updated_item.sell_in == item.sell_in - 1
    assert updated_item.quality == item.quality - 1
  end

  test "Once the sell by date has passed, Quality degrades twice as fast" do
    items = [%Item{name: "+5 Dexterity Vest", sell_in: -5, quality: 20}, 
             %Item{name: "+5 Dexterity Vest", sell_in: 0, quality: 20}]
    res = GildedRose.update_quality(items)
    assert res === Enum.map(items, &(%{&1 | sell_in: &1.sell_in - 1, quality: &1.quality - 2}))
    #assert updated_item.sell_in == item.sell_in - 1
    #assert updated_item.quality == item.quality - 2
  end

  test "The Quality of an item is never negative" do
    items = [%Item{name: "+5 Dexterity Vest", sell_in: 0, quality: 1}, 
             %Item{name: "+5 Dexterity Vest", sell_in: 5, quality: 0},
             %Item{name: "+5 Dexterity Vest", sell_in: 0, quality: 0}]
    #item = %Item{name: "+5 Dexterity Vest", sell_in: 4, quality: 0}
    #[updated_item] = GildedRose.update_quality([item])
    #assert updated_item.sell_in == item.sell_in - 1
    #assert updated_item.quality == item.quality
    [updated_item] = GildedRose.update_quality(items)
    assert res === Enum.map(items, &(%{&1 | sell_in: &1.sell_in - 1, quality: 0 }))
  end


  test " “Aged Brie” actually increases in Quality the older it gets" do
    item = %Item{name: "Aged Brie", sell_in: 7, quality: 1}
    [updated_item] = GildedRose.update_quality([item])
    assert updated_item.sell_in == item.sell_in - 1
    assert updated_item.quality == item.quality + 1
  end 

  test "The Quality of an item is never more than 50" do
    item = %Item{name: "Aged Brie", sell_in: 7, quality: 50}
    [updated_item] = GildedRose.update_quality([item])
    assert updated_item.sell_in == item.sell_in - 1
    assert updated_item.quality == item.quality
  end

  test "“Sulfuras”, being a legendary item, never has to be sold or decreases in Quality" do
    item = %Item{name: "Sulfuras" , sell_in: 7, quality: 50}
    [updated_item] = GildedRose.update_quality([item])
    assert updated_item.sell_in == item.sell_in
    assert updated_item.quality == item.quality
  end

  test "“Backstage passes” less 5" do
    item = %Item{name: "Backstage passes" , sell_in: 4, quality: 5}
    [updated_item] = GildedRose.update_quality([item])
    assert updated_item.sell_in == item.sell_in - 1
    assert updated_item.quality == item.quality + 3
  end

  test "“Backstage passes ” less 10 " do
    item = %Item{name: "Backstage passes" , sell_in: 9, quality: 5}
    [updated_item] = GildedRose.update_quality([item])
    assert updated_item.sell_in == item.sell_in - 1
    assert updated_item.quality == item.quality + 2
  end

  test "“Backstage passes” concert over" do
    item = %Item{name: "Backstage passes" , sell_in: 0, quality: 5}
    [updated_item] = GildedRose.update_quality([item])
    assert updated_item.sell_in == item.sell_in - 1
    assert updated_item.quality == 0
  end

  test "“Conjured” items degrade in Quality twice as fast as normal items" do
    item = %Item{name: "+5 Dexterity Vest", sell_in: -2, quality: 5}
    [updated_item] = GildedRose.update_quality([item])
    assert updated_item.sell_in == item.sell_in - 1
    assert updated_item.quality == item.quality - 2
  end
end