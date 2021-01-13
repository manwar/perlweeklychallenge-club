#!/usr/bin/env raku

use v6;

#| Print the Collatz list for target
multi sub MAIN(
    UInt \target #= Number to print the target for
){
    (target,{collatz($^a)}...1).join(' -> ').say;
}

multi sub collatz( UInt \n where { n %% 2 } ) { n div 2; }

multi sub collatz( UInt \n where { n !%% 2 } ) { (3 * n) + 1; }
