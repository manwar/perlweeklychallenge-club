#!/usr/bin/env raku

use v6;

#| Given two Integers demonstrate Ethiopian Multiplication with them
sub MAIN ( UInt $A is copy, UInt $B is copy ) {
    my @parts;
    say "Given $A and $B {$A %% 2 ?? '' !! '*'}";
    @parts.push($B) unless $A %% 2;
    while ( $A > 1 ) {
        $A div= 2;
        $B *= 2;
        say "Got $A and $B {$A %% 2 ?? '' !! '*'}";
        @parts.push($B) unless $A %% 2;
    }
    say "Adding {@parts.join(",")} to get {[+] @parts}";
}
