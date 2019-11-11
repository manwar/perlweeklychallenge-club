#!/usr/bin/env perl6

use v6;

# Possible actions
sub doubler ( Int $x ) { $x * 2 }
sub halver ( Int $x ) { $x / 2 }
sub squarer ( Int $x ) { $x * $x }
sub reverser ( Int $x ) { $x.flip.Int }
sub zeroer ( Int $x ) { 0 }

# Despatch table
my %commands = (
    "double"  => &doubler,
    "halve"   => &halver,
    "square"  => &squarer,
    "reverse" => &reverser,
    "zero"    => &zeroer,
);

#| Help
multi sub MAIN( Bool :h(:$help) where so * ) {
    say $*USAGE;
}

#| Use despatch table to run the given command
multi sub MAIN(
    Str $command where { %commands{$command}:exists }, #= Valid command from double, halve, square, reverse, zero
    Int() $value #= Value to apply command to
) {
    say "{$command}( {$value} ) => {%commands{$command}($value)}"; 
}
