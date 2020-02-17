#!/usr/bin/env perl6

use v6.d;

# I know there's a mathematical model for this (I saw a video on it)
# But I can't remember it so the default version will just calculate it.

#| Calculate the survior of the swordsmen suicide pact
multi sub MAIN(
    UInt $swords = 50, #= Number of swordsmen (default 50)
) {
    my @men = [1..$swords];
    while ( @men.elems > 1 ) {
        my ( $alive, $dead ) = @men.splice(0,2);
        @men.push($alive);
    }

    say "Survivor of $swords is number {@men[0]}";
}

# So after doing that I got it.
# Find p where p ** 2 < s (swordsmen)
# The survior is the nth odd number where n = s - p 

#| Calculate mathematically
multi sub MAIN(
    "math", 
    UInt $swords = 50, #= Number of swordsmen
) {
    my $low-power = (1,* * 2...*).first(* > $swords) div 2;
    say "Survivor of $swords is number {(1,3,5...*)[$swords - $low-power]}";
}
