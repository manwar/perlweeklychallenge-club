#!/usr/bin/env raku

sub chowla-number ( $n ) {
    2 .. $n / 2
    andthen .grep: $n %% *
    andthen .sum
}

constant @chowla-numbers = (1 .. ∞).map: &chowla-number;

multi MAIN (Bool :test($)!) {
    use Test;
    is @chowla-numbers.head(20), (0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21);
    my $big-prime = (100_000 .. ∞).first: *.is-prime;
    is chowla-number($big-prime), 0;
    done-testing;
}

multi MAIN ($n=20) {
    put @chowla-numbers.head($n)
}
