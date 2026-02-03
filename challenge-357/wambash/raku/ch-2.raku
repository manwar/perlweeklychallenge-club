#!/usr/bin/env raku

sub unique-fraction-generator ($int) {
    1..$int X/ 1..$int
    andthen .sort
    andthen .squish
    andthen .map: { RatStr.new(.Rat, .nude.join: '/') }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply unique-fraction-generator(3), <1/3 1/2 2/3 1/1 3/2 2/1 3/1>;
    is-deeply unique-fraction-generator(4), <1/4 1/3 1/2 2/3 3/4 1/1 4/3 3/2 2/1 3/1 4/1>;
    is-deeply unique-fraction-generator(1), (< 1/1 >, );
    is-deeply unique-fraction-generator(6), <
        1/6 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4
        4/5 5/6 1/1 6/5 5/4 4/3 3/2 5/3 2/1
        5/2 3/1 4/1 5/1 6/1
    >;
    is-deeply unique-fraction-generator(5), <
        1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1
        5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1
    >;
    done-testing;
}

multi MAIN ($int) {
    put unique-fraction-generator $int;
}
