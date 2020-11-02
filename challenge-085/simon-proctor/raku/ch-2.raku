#!/usr/bin/env raku

use v6;

#| Given a number return 1 if it can be expressed as a integer power of an integer
sub MAIN ( UInt $N ) {
    # Technically works but it's overkill
    #(so any((1..$N) X** (2..$N)) == $N).Int.say;
    
    A: for 1..$N -> $a {
        for 2..$N -> $b {
            if $a ** $b == $N {
                say 1;
                exit;
            }
            next A if $a ** $b > $N;
        }
    }

    say 0;
}
