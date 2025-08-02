#!raku

#
# Perl Weekly Challenge 316
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-316>
#

sub MAIN( *@words where { @words.elems > 0 } ) {

    for 0 ..^ @words.elems - 1 {
	my $ending = @words[ $_ ].comb[ * - 1 ].fc;
	my $beginning = @words[ $_ + 1 ].comb[ 0 ].fc;
	'False'.say and exit unless ( $beginning ~~ $ending );
    }

    'True'.say;
}
