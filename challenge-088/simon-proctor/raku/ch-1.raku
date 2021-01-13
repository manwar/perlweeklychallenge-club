#!/usr/bin/env raku

use v6;

multi sub MAIN(
    'ex1' #= Example 1 (5, 2, 1, 4, 3)
) {
    product-array( [5,2,1,4,3] ).join(", ").say;
}


multi sub MAIN(
    'ex2' #= Example 2 (2, 1, 4, 3)
) {
    product-array( [2,1,4,3] ).join(", ").say;
}
 
#| Given a list of Integers return the list of products for each item barring the one at the same index
multi sub MAIN(
    *@N where { $_.all ~~ Int }
) {
    product-array( @N ).join(", ").say;
}

sub product-array( @N ) {
    my @M;
    for @N.keys -> $i {
        @M[$i] = [*] @N[ @N.keys.grep(!(*~~$i)) ] 
    }
    @M;
}
 
