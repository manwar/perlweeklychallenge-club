#!/usr/bin/env raku

use v6;

#| Given three strings return 1 if the third string ($C) can be made by interleaving $A and $B
sub MAIN ( Str $A, Str $B, Str $C ) {
    ( any( |possible-interleaves($A,$B), |possible-interleaves($B,$A) ) ~~ $C ).Int.say;
}

sub possible-interleaves( Str $out, Str $sub ) {
    (0..$out.codes).map( { my $x = $out; $x.substr-rw($_,0) = $sub; $x } )
}
