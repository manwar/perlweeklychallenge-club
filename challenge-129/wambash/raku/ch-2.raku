#!/usr/bin/env raku

sub linked-list-to-int ( $ll ) {
    $ll
    andthen $_, *.value  ... * ~~ Int
    andthen .map: { .?key // $_}\
    andthen [~] $_
    andthen .Int
}

sub  add_linked_lists (+@a) {
    @a
    andthen .map: *.&linked-list-to-int
    andthen .sum
    andthen [=>] .comb
}

multi MAIN (Bool :test($)!) {
    use Test;
    is linked-list-to-int( 1=>2=>3 ), 123;
    is add_linked_lists(1=>2=>3,3=>2=>1), 4=>4=>4;
    is add_linked_lists(1=>2=>3=>4=>5,6=>5=>5), 1=>3=>0=>0=>0;
    done-testing;
}
