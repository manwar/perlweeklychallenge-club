#!/usr/bin/env perl6

use v6;

sub perfect-from-prime( Int $p where { $p.is-prime && is-mersine( $p ) } ) is pure {
    return (2**($p-1)) * ((2**$p) -1 ); 
}

multi sub is-mersine( Int $ ) is pure { False; }

multi sub is-mersine( Int $p where ((2**$p)-1).is-prime ) is pure { True; }

#| Help
multi sub MAIN ( Bool :h($help) where *.so ) {
    say $*USAGE;
}

#| Give the first X perfect integers
multi sub MAIN ( 
    Int $x = 5; #= Number of perfect integers to return (default 5)
) { 
    .say for (0..*).grep( *.is-prime ).grep( { is-mersine( $_ ) } ).map( { perfect-from-prime($_) } )[^$x];
}

