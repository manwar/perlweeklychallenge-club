#!/usr/bin/env raku

use v6;

#| Given two strings find the common root strings 
sub MAIN ( Str $a, Str $b ) {
    .say for ( get-roots($a) (&) get-roots($b) ).keys;
}

sub get-roots( Str $a ) {
    ($a ~~ m:ex/^ (.+?) $0* $/).map(*[0].Str);
}
    
