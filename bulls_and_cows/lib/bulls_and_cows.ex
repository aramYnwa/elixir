defmodule BullsAndCows do
    def score_guess(word, guess) do
        l_word  = String.to_integer(word) |> Integer.digits
        l_guess = String.to_integer(guess) |> Integer.digits
        bull_count = getBullCount(l_word, l_guess)
        cow_count  = getCowCount(l_word, l_guess)
        game(bull_count, cow_count)
    end

    def getBullCount([], []), do: 0
    def getBullCount(l_word, l_guess) when hd(l_word) == hd(l_guess), do: 1 + getBullCount(tl(l_word), tl(l_guess))
    def getBullCount(l_word, l_guess), do: getBullCount(tl(l_word), tl(l_guess))
    
    def getCowCount(l_word, l_guess), do: length (l_word -- (l_word -- l_guess))

    def game(bull_count, cow_count) when bull_count == 4, do: "You win"
    def game(bull_count, cow_count), do: "#{bull_count} Bulls, #{cow_count - bull_count} Cows"
end
