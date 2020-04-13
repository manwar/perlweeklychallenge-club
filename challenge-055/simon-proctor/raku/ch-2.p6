#!/usr/bin/env raku

use v6;

#| Make a random list of length N integers between -100 and 100 then give the wave sorted versions
multi sub MAIN (
    UInt $n where 2 <= * <= 20 #= Positive integer 2 <= N <= 20
) {
    MAIN( |(-100..100).roll($n) );
}

multi sub MAIN( *@ ) is hidden-from-USAGE { say "Please give a list of 2 or more items or a single integer greater then 1";say $*USAGE; }                                                               

#| Given a list of integers return all the wave sorted lists
multi sub MAIN( *@input where { $_.elems >= 2 && $_.all ~~ Int } ) {
    .say for unique-perms( @input ).race.grep( -> @l { is-wave( 'gte', |@l ) } );
}

sub unique-perms ( @input ) {
    @input.permutations.unique(:as(*.join(",")));
}

multi sub is-wave( 'lte', Int $a, Int $b where { $a <= $b } )          { True }
multi sub is-wave( 'lte', Int $a, Int $b where { $a > $b } )           { False }
multi sub is-wave( 'gte', Int $a, Int $b where { $a >= $b } )          { True }
multi sub is-wave( 'gte', Int $a, Int $b where { $a < $b } )           { False }
multi sub is-wave( 'gte', Int $a, Int $b where { $b > $a }, *@ )       { False }
multi sub is-wave( 'lte', Int $a, Int $b where { $a > $b }, *@ )       { False }
multi sub is-wave( 'gte', Int $a, Int $b where { $a >= $b }, $c, *@r ) { True && is-wave( 'lte', $b, $c, |@r ); }
multi sub is-wave( 'lte', Int $a, Int $b where { $a <= $b }, $c, *@r ) { True && is-wave( 'gte', $b, $c, |@r ); }
