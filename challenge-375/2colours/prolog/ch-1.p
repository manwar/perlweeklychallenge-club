task(Array1, Array2, Output) :-
        maplist([In, Out]>>(
                msort(In, Sorted),
                clumped(Sorted, Clumped),
                include([_-1]>>true, Clumped, Out)
                ), [Array1, Array2], [Array1_Unique, Array2_Unique]),
        ord_intersect(Array1_Unique, Array2_Unique, Common_Words),
        length(Common_Words, Output).
