    defmodule TabPlayer do

        # We read the tabs and get rid of symbols we do not need.
        def readTab(tab) do
            Regex.scan(~r/\w\|.*+/, tab)
            |> List.flatten
            |> Enum.map(fn n -> [String.first(n)|List.flatten(Regex.scan(~r/\d|-{1}+/, n))] end)    
        end

        def concatTuple(elem, []), do: []
        def concatTuple(elem, [head | tail]) when head == "-" do
            [head | concatTuple(elem,tail)]
        end
        def concatTuple(elem, [head | tail]), do: [elem <> head | concatTuple(elem, tail)]
       
        def removeDashes([]), do: ["-"]
        def removeDashes([head | tail]) when head != "-" do
            [head | removeDashes(tail)]
        end
        def removeDashes([head | tail]), do: removeDashes(tail)
    
        def findSilence([]), do: []
        def findSilence([["-"],["-"],["-"] | tail]) do 
           [["_"] | findSilence tail]
        end

        def findSilence([head | tail]) when head == ["-"] do
           findSilence tail
        end

        def findSilence([head | tail]) do
         [head | findSilence tail]
        end
     
        def dashToSlash([]), do: []
       
        def dashToSlash([head|tail]) when head == "-" do
           dashToSlash tail
        end

        def dashToSlash([head | [head1 | tail]]) when (head1 != "-" and head1 != "_" and head != "_") do
            [[head,"/"] | dashToSlash [head1 | tail]]
        end

        def dashToSlash([head | tail]) when (tail == [] or tail == ["-"]) do
           [head]
        end

        def dashToSlash([head | tail]) do
              [[head, " "] | dashToSlash tail]
        end

        def parse(tab) do
                 tab = readTab(tab)
            |> Enum.map(fn n-> concatTuple hd(n), n end) 
            |> Enum.map(fn n -> tl(n) end)
            |> Enum.zip()
            |> Enum.map(fn n-> Tuple.to_list n end)
            |> Enum.map(fn n-> removeDashes n end)
            |> (fn n -> findSilence n end).()
            |> List.flatten
            |> (fn n-> dashToSlash n end).()
            |> Enum.join()
        end
    end