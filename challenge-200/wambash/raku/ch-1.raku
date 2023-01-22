#!/usr/bin/env raku
use v6.e.PREVIEW;

sub is-arithmetic-slice (+@list) {
    @list
    #andthen .snitch
    andthen .rotor: 2 => -1
    andthen .map: -> ($a,$b) { $b - $a }\
    andthen [==] $_
}

sub arithmetic-slices (+@list) {
   @list
   andthen m:s:ex/(\d+) **? 3..*  <?{ is-arithmetic-slice $/.[0] }>/
   andthen .map: *.[0]».Int
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply arithmetic-slices(1,2,3,4),([1,2,3],[1,2,3,4],[2,3,4]);
    is-deeply arithmetic-slices(2),();
    is-deeply arithmetic-slices(1,2,3,5,7),([1,2,3],[3,5,7]);
    is-deeply arithmetic-slices(1,2,3,5,7,10,14,19,29,39),([1,2,3],[3,5,7],[19,29,39]);
    done-testing;
}

multi MAIN (+@list) {
    say arithmetic-slices +@list
}
