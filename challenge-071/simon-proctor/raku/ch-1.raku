#!/usr/bin/env raku

use v6;

# Generate a list of random numbers then find the picks
sub MAIN(
    UInt $N where 1 < * <= 50 #= Size of random number list
) {
    my @list = (1..50).pick($N);
    my @peaks = ( 0, |@list, |0 ).rotor(3 => -2).grep( { $_[0] < $_[1] > $_[2] } ).map( { $_[1] } );
    say "List  : {@list.join(',')}";
    say "Peaks : {@peaks.join(',')}";

}
