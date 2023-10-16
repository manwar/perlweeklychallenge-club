#!raku

#
# Perl Weekly Challenge 238
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-238/>
#

sub MAIN( *@nums where { @nums.grep( { $_ ~~ Int && $_ > 0 } ).elems == @nums.elems } ) {
    my %steps;
    for @nums {
	my $step-counter = 0;
	my $value = $_;
	while ( $value > 9 ) {
	    $value = [*] $value.comb;
	    $step-counter++;
	}

	%steps{ $step-counter }.push: $_;
    }

    my @running-sort.push: | %steps{ $_ }.sort for %steps.keys.sort;
    @running-sort.join( ', ' ).say;

}
