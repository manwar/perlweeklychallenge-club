sub task2 ( @a ) {
    my $best =
        @a.pairs                         # index => element
        .classify( {.value}, :as{.key} ) # element_A => [Ai0, Ai1, … Ai_last], …
        .map({ .value })                 # [Ai0, Ai1, … Ai_last], [Bi0, Bi1, … Bi_last], …
        .max({ .elems, -(.tail - .head + 1), -.head }); # Highest degree with lowest slice_size

    return @a[ $best.head .. $best.tail ];
}


my @tests =
    # From TWC examples:
    ( (1, 3, 3, 2)    , (3, 3)       ),
    ( (1, 2, 1, 3)    , (1, 2, 1)    ),
    ( (1, 3, 2, 1, 2) , (2, 1, 2)    ),
    ( (1, 1, 2, 3, 2) , (1, 1)       ),
    ( (2, 1, 2, 1, 1) , (1, 2, 1, 1) ),

    # TWC examples translated to alpha, for easier debugging.
    ( <A C C B  > , <C C>     ),
    ( <A B A C  > , <A B A>   ),
    ( <A C B A B> , <B A B>   ),
    ( <A A B C B> , <A A>     ),
    ( <B A B A A> , <A B A A> ),
    
    # Numeric and alpha versions to stress tie-breaking rules:
    ( <1 1 2 2 2 2 1 1>   , <2 2 2 2> ),
    ( <A A B B B B A A>   , <B B B B> ),
    ( <1 1 1 1 2 2 2 2>   , <1 1 1 1> ),
    ( <A A A A B B B B>   , <A A A A> ),
    ( <1 1 1 1 2 3 2 2 2> , <1 1 1 1> ),
    ( <A A A A B C B B B> , <A A A A> ),
;
use Test;
plan +@tests;
for @tests -> ( @array, @expected ) {
    is-deeply task2(@array), @expected, "task2(<@array[]>)";
}
