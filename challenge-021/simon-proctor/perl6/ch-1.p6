#!/usr/bin/env perl6

use v6;

multi sub MAIN( Bool :h(:$help) where so * ) { say $*USAGE; }

#| Calulate Eulers number for up to <limit> (defaults 100)
#| also displays the system default version to compare
multi sub MAIN( 
        UInt $limit = 100 #= Max value of n to calcluate to
) {
    my multi sub fact( 0 ) { 1 }
    my multi sub fact( UInt $n ) { [*] 1..$n }

    say "Calcuated to n={$limit} {[+] (0..$limit).map({FatRat.new( 1, fact($_))})}";
    say "Constant {e}";
}
