    defmodule TabPlayer do
        def preadTab(tab) do
            Regex.scan(~r/\w\|.*+/, tab)
            |> List.flatten
            |> Enum.map(fn n -> [String.first(n)|List.flatten(Regex.scan(~r/\d|-{1}+/, n))] end)    
        end

        def transformLine([]) do 
             []
        end
        def transformLine(["-","-","-" | tail]) do 
            ["_" | transformLine tail]
        end



        def transformLine([head | tail]) do
           [head | transformLine tail]
        end

        def concatTuple(elem, []) do
            []
        end 
        def concatTuple(elem, [head | tail]) when head == "-" do
            [head | concatTuple(elem,tail)]
        end

        def concatTuple(elem, [head | tail]) do
               [elem <> head | concatTuple(elem, tail)]
        end
       
        def noteJoin([]) do

            ["-"]
        end

        def noteJoin([head | tail]) when head != "-" do

            [head | noteJoin(tail)]
        end

        def noteJoin([head | tail]) do
            
            noteJoin(tail)
        end

        def t1 ([]) do
            []
        end
        def t1 ([head | [in_head | tail]]) do
            [head | t1(tail)]
        end
    
       
        def delete_empt ([]) do
            []
        end 

       def tr([]) do 
            []
       end
       def tr([["-"],["-"],["-"] | tail]) do 
           [["_"] | tr tail]
       end
       
       def tr([head | tail]) when head == ["-"] do
           tr tail
       end

       def tr([head | tail]) do
        [head | tr tail]
       end
     
       def finall ([]) do
           []
       end

       def finall([head | tail]) when length(head) == 1 do
           [head | finall tail]
       end

       def finall([head | tail]) do
           
       end

       def aggr([]) do
           []
       end

       
       def aggr([head|tail]) when head == "-" do
           aggr tail
       end

       def aggr([head | [head1 | tail]]) when (head1 != "-" and head1 != "_" and head != "_") do
           #Kernel.inspect(head) <> "/" <> Kernel.inspect(aggr([head1 | tail]))
           [[head,"/"] | aggr [head1 | tail]]
       end

       def aggr([head | tail]) when (tail == [] or tail == ["-"]) do
           [head]
       end

       def aggr([head | tail]) do
           [[head, " "] | aggr tail]
       end

        def parse (tab) do
                 tab = preadTab(tab)
            |> Enum.map(fn n-> concatTuple hd(n), n end) 
            |> Enum.map(fn n -> tl(n) end)
            |> Enum.zip()
            |> Enum.map(fn n-> Tuple.to_list n end)
            |> Enum.map(fn n-> noteJoin n end)
            |> (fn n -> tr n end).()
            |> List.flatten
            |> (fn n-> aggr n end).()
            |> Enum.join()
        end
    end