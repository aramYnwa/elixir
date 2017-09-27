defmodule Bowling do

  def score([]) do 
    0
  end

  def score([s | t]) when is_list(s) do
    List.flatten(s ++ t)
    |> Enum.filter(fn e -> is_number(e) end)
    |> score()
  end
  
  def score([s | t]) when length(t) == 2 do
    s + Enum.sum(Enum.slice(t, 0, 2))
  end

  def score([s | t]) when s == 10 do
    s + Enum.sum(Enum.slice(t, 0, 2)) + score (t)
 end
  
  def score([s | [s1 | t]]) when s + s1 == 10 do
     s + s1 + List.first(t) + score (t)
  end

  
  def score([s | t]) do
    s + score (t)
 end
end
