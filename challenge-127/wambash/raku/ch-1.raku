#!/usr/bin/env raku

sub disjoint-set (Set() \M, Set() \N) {
    M ∩ N ≡ ∅
}

multi MAIN () {
    lines()
    andthen .map: *.words
    andthen disjoint-set(|.head(2))
    andthen .say
}

multi MAIN (Bool :test($)!) {
     use Test;
     nok disjoint-set( (1,2,5,3,4), (4,6,7,8,9) );
     ok  disjoint-set( (1,3,5,7,9), (0,2,4,6,8) );
     done-testing;
}

