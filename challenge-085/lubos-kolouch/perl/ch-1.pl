#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: The weekly challenge #085
#  				https://perlweeklychallenge.org/blog/perl-weekly-challenge-085/
#  				Task 1 - Triplet Sum
#
#       AUTHOR: Lubos Kolouch
#===============================================================================

use strict;
use warnings;
use List::Util qw/sum/;
use Math::Combinatorics;

sub is_triplet_existing {
	my $in_arr = shift;

	# we can exclude any numbers greater than 2, the upper limit
	my @limited_arr = grep { $_ < 2 } @$in_arr;

	# exit if we don't have at least a triplet left
	return 0 if scalar @limited_arr < 3;

	# Create a generator of combinations
	my $combinat = Math::Combinatorics->new(count => 3,
                                        	data => [@limited_arr],
                                       	);

	# Loop throug the combinator, exit if found a valid combination
	while(my @comb = $combinat->next_combination){
		my $arr_sum = sum(@comb);
		return 1 if ($arr_sum > 1) and ($arr_sum < 2);
	}

	# Bad luck, return 0
	return 0;
}

use Test::More;

is(is_triplet_existing([1.2, 0.4, 0.1, 2.5]), 1);
is(is_triplet_existing([0.2, 1.5, 0.9, 1.1]), 0);
is(is_triplet_existing([0.5, 1.1, 0.3, 0.7]), 1);
is(is_triplet_existing([1, 2, 4, 6]), 0);

done_testing;



