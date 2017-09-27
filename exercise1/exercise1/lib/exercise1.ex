defmodule Exercise1 do
    def reverse(list) do
        MList.foldl(list, [], fn (h, a) -> [h|a] end)
    end

    def upcase(list) do
        MList.map(list, fn c when c in ?a..?z -> c - ?a + ?A; c -> c end)
    end

    def remove_non_alpha(list) do
        MList.filter(list, fn c -> c in ?a..?z or c in ?A..?Z end)
    end

    def palindrome (list) do
        #remove_non_alpha(upcase(list)) == remove_non_alpha(upcase(reverse(list)))
        reversed = remove_non_alpha(list)
            |> upcase
            |> reverse

        reversed == remove_non_alpha(list)
            |> upcase    
    end
end
