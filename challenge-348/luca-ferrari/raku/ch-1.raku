#!raku

#
# Perl Weekly Challenge 348
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-348>
#

sub MAIN( Str $string ) {
    # if the string has an even length, nothing to do
    'False'.say and exit( 1 ) if ( $string.chars !%% 2 );
    'False'.say and exit( 2 ) unless ( $string.comb[ 0 ..^ $string.chars / 2 ].fc.grep( * ~~ /<[aeiou]>/ ).elems ==
				       $string.comb[ $string.chars / 2  .. * ].fc.grep( * ~~ /<[aeiou]>/ ).elems );


    'True'.say;
}
