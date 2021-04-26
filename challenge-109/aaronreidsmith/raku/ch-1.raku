#!/usr/bin/env raku

sub challenge(Int $n) returns Int {
    (2..$n / 2).grep($n %% *).sum;
}

multi sub MAIN(Int $terms = 20, Bool :$main) {
    say (1..$terms).map(&challenge).join(', ');
}

multi sub MAIN(Bool :$test) {
    use Test;

    is((1..20).map(&challenge), (0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21));

    done-testing;
}
