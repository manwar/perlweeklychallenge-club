#! /usr/bin/env raku

# Sylvester’s sequence
# https://oeis.org/A000058

multi sylvester (  0 ) { 2 }
multi sylvester ( $n ) { sylvester( $n-1 )² - sylvester( $n-1 ) + 1 }

say .&sylvester for ^10
