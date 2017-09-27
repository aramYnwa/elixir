defmodule BinaryTree do

  @doc """
  def insert({value, left, right}, new_value) do
    if new_value < value do
      {value, insert(left, new_value), right}
    else
      {value, left, insert(right, new_value)}
    end
  end

  def insert(nil, new_value) do
    {new_value, nil, nil}
  end
  """
  def insert({value, left, right}, new_value) when new_value < value, do: {value, insert(left, new_value), right}
  def insert({value, left, right}, new_value), do: {value, left, insert(right, new_value)}
  def insert(nil, new_value), do: {new_value, nil, nil}

  
end
