defmodule MyList do
    def map([]) do
        []
    end

    def map([head | tail]) do
        [head + 2 | map(tail)]
    end

    def fold([], acc, _), do: acc
    def fold([head | tail], acc, fun), do: fold(tail, fun.(head, acc), fun)
end