#!raku

#
# Perl Weekly Challenge 317
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-317>
#

sub MAIN( Str $needle, Str $haystack where { $haystack.chars == $needle.chars } ) {
    # short circuit: the strings are the same
    'True'.say if ( $needle.fc ~~ $haystack.fc );

    my $differences = 0;
    my @needle = $needle.lc.comb;
    my @haystack = $haystack.lc.comb;

    for 0 ..^ @needle.elems {
	$differences++ unless ( @needle[ $_ ] eq @haystack[ $_ ] );
    }

    'True'.say and exit if ( $differences == 2 );
    'False'.say;
}
