#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 303 Task 2: Delete and Earn
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub find_best_score( $available ) {
    # Try all available numbers in turn,
    # and descend into a recursion if there are any numbers left.
    my $best_score = 0;
    for ( keys $available->%* ) {

	# Decrease the availablity of the chosen number n by one,
	# and remove all numbers n + 1  and numbers n - 1.
	my %still_available = $available->%*;
	delete $still_available{$_}
	    if --$still_available{$_} == 0;
	delete $still_available{ $_ + 1 };
	delete $still_available{ $_ - 1 };

	# Compute the score for having used this number,
	# and the best score from using what is left.
	my $score = $_ + find_best_score( \%still_available );

	# Keep the best score found so far.
	$best_score = $score
	    if $score > $best_score;
    }
    return $best_score;
}

use List::MoreUtils qw( frequency );

sub delete_and_earn( @ints ) {
    my %available = frequency @ints;
    return find_best_score( \%available );
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is delete_and_earn( 3, 4, 2 ), 6,
    'Example 1: delete_and_earn( 3, 4, 2 ) == 6';
is delete_and_earn( 2, 2, 3, 3, 3, 4 ), 9,
    'Example 2: delete_and_earn( 2, 2, 3, 3, 3, 4 ) == 9';

done_testing;
