#!/usr/bin/env raku

sub squares-sum ($n)  { $n
  andthen .comb
  andthen .map: * ** 2
  andthen .sum
}

sub is-happy ($n) {
    my @turtle = $n, *.&squares-sum ... * ;
    my @hare = $n.&squares-sum, *.&squares-sum.&squares-sum ... *;
    @turtle Z=> (@turtle Z== @hare)
    andthen .first: *.value
    andthen .key == 1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is is-happy(19), True;
    is is-happy( 1), True;
    is is-happy( 2), False;
    done-testing;
}

multi MAIN ($n = 8) {
    ^∞
    andthen .grep: *.&is-happy
    andthen .head: $n
    andthen .put
}
