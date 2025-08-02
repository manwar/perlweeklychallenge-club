#!raku

#
# Perl Weekly Challenge 329
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-329>
#

sub MAIN( Str $string where { $string ~~ / <[a..zA..Z]>+ / } ) {
    exit( 0 ) if $string.chars <= 1;

    my @chars = $string.comb;
    my $found;

    for 0 ..^ @chars.elems {
	my $current = @chars[ $_ ];
	my $needle  = $current.uc;
	$needle = $current.lc if ( $current ~~ / <[A..Z]> / );

	my $last-index = @chars[ $_ .. * - 1 ].grep( * ~~ $needle, :k ).max;
	my $match = @chars[ $_ .. $last-index ].join;
	$found = $match if ( ! $found || $match.chars > $found.chars );
    }

    $found.say;

}
