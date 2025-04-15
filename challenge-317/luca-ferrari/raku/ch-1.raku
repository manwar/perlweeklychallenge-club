#!raku

#
# Perl Weekly Challenge 317
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-317>
#

sub MAIN( Str $acronym, *@words where { @words.elems == $acronym.chars } ) {
    'True'.say and exit if ( @words.map( *.fc.comb[ 0 ] ).join ~~ $acronym.fc );
    'False'.say;
}
