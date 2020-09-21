#!/usr/bin/env raku

multi leader-element ( +@a, :$reverse! where *.not ) {
    @a
    andthen [\max] $_
    andthen .squish
}

multi leader-element ( +@a, :$reverse = True ) {
    @a
    andthen .reverse
    andthen *.&leader-element: :!reverse
    andthen .reverse
}

multi MAIN ( :$test! ) {
    use Test;
    is leader-element(9, 10, 7, 5, 6, 1), (10, 7, 6, 1);
    is leader-element(3, 4, 5), (5,);
    done-testing;
}
