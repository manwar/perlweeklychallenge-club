#!/usr/bin/env raku

sub unique-array (+@list) {
   @list.unique: with => &[eqv]
}

multi MAIN (Bool :test($)!) {
    use Test;
    is unique-array([1,2], [3,4], [5,6], [1,2]), ([1,2], [3,4], [5,6]);
    is-deeply unique-array([9,1], [3,7], [2,5], [2,5]),([9, 1], [3,7], [2,5]);
    done-testing;
}

multi MAIN (*@list) {
    @list
    andthen .map: *.split( ',' ).Array
    andthen unique-array $_
    andthen .say
}
