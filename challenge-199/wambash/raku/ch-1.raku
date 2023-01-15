#!/usr/bin/env raku

sub good-pairs (+@list) {
   @list
   andthen $_, *.repeated ^...^ :!elems
   andthen .map: *.elems
   andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is good-pairs(1,2,3,1,1,3),4;
    is good-pairs(1,2,3),0;
    is good-pairs(1,1,1,1),6;
    done-testing;
}

multi MAIN (*@list) {
    say good-pairs @list
}
