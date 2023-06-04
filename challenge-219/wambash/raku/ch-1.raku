#!/usr/bin/env raku

sub sorted-squares (+@list) {
    @list
    andthen .map: *²
    andthen .sort
}

multi MAIN (Bool :test($)!) {
    use Test;
    is sorted-squares(-2,-1,0,3,4),(0,1,4,9,16);
    is sorted-squares(5, -4, -1, 3, 6),(1, 9, 16, 25, 36);
    done-testing;
}

multi MAIN (*@list) {
    say sorted-squares @list
}
