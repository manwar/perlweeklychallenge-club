#!raku

#
# Perl Weekly Challenge 316
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-316>
#

sub MAIN( Str $original, Str $subsequence ) {
    my $index = 0;
    for $original.lc.comb  {
	'False'.say and exit unless ( $subsequence.comb[ $index .. * ].grep( $_ ) );
	$index = $subsequence.comb[ $index .. * ].grep( $_,  :k )[ 0 ];
    }

    'True'.say;

}
