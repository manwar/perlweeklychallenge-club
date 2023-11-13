#!raku

#
# Perl Weekly Challenge 241
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-241/>
#


sub prime_factors (Int $n) {
    return $n if $n <= 1;
    my $residue = $n;
    my @factors;

    for 2 .. $n {
	while ( $residue %% $_ ) {
	    @factors.push: $_;
	    $residue /= $_;
	}

	last if $residue == 1;
    }

    return @factors;
}

sub MAIN( *@nums where { @nums.grep( * ~~Int ).elems == @nums.elems } ) {
    my %sorted;
    for @nums {
	%sorted{ prime_factors( $_.Int ).elems }.push: $_;
    }

    %sorted{ $_ }.join( "," ).say for  %sorted.keys.sort;
}
