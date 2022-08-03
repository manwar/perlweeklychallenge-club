#!/usr/bin/env raku

#= Find the first positive integer x such that x, 2x, 3x, 4x, 5x and 6x are permuted multiples of each other
sub MAIN() {
    (1..*).hyper.grep({[==] ((1..6) >>*>> $_).map( *.comb.sort.join );}).first().say;
}
