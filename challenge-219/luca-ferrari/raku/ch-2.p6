#!raku

#
# Perl Weekly Challenge 219
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-219/>
#

sub MAIN() {

    my @days  = 1, 5, 6, 7, 9, 15;

    # sort the days
    @days .= sort;

    my %costs;
    %costs<1> = 2;
    %costs<7> = 7;
    %costs<30> = 25;

    my @evaluated;
    @evaluated.push: { cost => 0, days => @days };
    my $current-cost = @days.elems * %costs<1>;

    while ( @evaluated.elems > 0 ) {
	my %entry = @evaluated.shift;

	if ( %entry<days>.elems == 0 ) {
	    $current-cost = %entry<cost> if ( %entry<cost> < $current-cost );
	}
	else {
	     next if ( %entry<cost> >= $current-cost );

	    my $begin-date = %entry<days>[ 0 ];
	    for %costs.keys {
		my $end-date = $begin-date + $_ - 1;
		my @uncovered-days = %entry<days>.grep( * > $end-date );
		my $cost = %entry<cost> + %costs{ $_ };
		@evaluated.push: { cost => $cost, days => @uncovered-days };
	    }
	}
    }

    say $current-cost;
}
