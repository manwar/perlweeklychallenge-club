#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 303 Task 1: 3-digits Even
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub fill_to_three_digits_even( $value, $available ) {
    # Build the resulting numbers from right to left.
    my @combinations;
    for ( keys $available->%* ) {

	# The last digit has to be even.
	next if $value eq "" && $_ % 2 != 0;

	my $number = "$_$value";
	
	# Check whether we have a 3-digit number now,
	# making sure the 3-digit number has no leading zero.
	if ( length( $number ) == 3 && $_ != 0 ) {
	    # We have a valid combination.
	    push @combinations, $number;
	}
	elsif ( length( $number ) < 3 ) {
	    # We need to add more from what is left.
	    my %still_available = $available->%*;
	    # Remove what we just used.
	    delete $still_available{$_}
		if --$still_available{$_} == 0;
	    push @combinations,
		fill_to_three_digits_even( $number, \%still_available );
	}
    }
    return @combinations;
}

use List::MoreUtils qw( frequency );

sub three_digits_even( @ints ) {
    my %available = frequency @ints;
    return fill_to_three_digits_even( "", \%available );
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is [ three_digits_even( 2, 1, 3, 0 ) ],
    bag { item $_ for 102, 120, 130, 132, 210, 230, 302, 310, 312, 320; end },
    "Example 1: 3_digits_even( 2, 1, 3, 0 )\n"
	. '    is bag( 102, 120, 130, 132, 210, 230, 302, 310, 312, 320 )';
is [ three_digits_even( 2, 2, 8, 8, 2 ) ],
    bag { item $_ for  222, 228, 282, 288, 822, 828, 882; end },
    "Example 2: 3_digits_even( 2, 2, 8, 8, 2 )\n"
        . '    is bag( 222, 228, 282, 288, 822, 828, 882 )';

done_testing;
