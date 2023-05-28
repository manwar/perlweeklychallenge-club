#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 218 Task 1: Maximum Product
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

use List::Util qw( product max );

sub maximum_product {
    my ( @list ) = @_;

    # First, trivial case of having exactly three numbers.
    return product( @list )
	if @list == 3;

    # First, we try to get the largest *positive* product possible.
    # It may be the product of 
    #  -  the three largest positive numbers,
    #  -  or the two negatives having the highest absolute value and the
    #     largest positive number
    #     (the two negatives turning the result into positive).
    # We cannot say in advance which of these will give us the better result,
    # so we need to compute them both (if possible) and compare.
    # To do so, we split up our list into positives and negatives,
    # sorted by highest to lowest absolute value:
    my @pos    = sort { abs( $b ) <=> abs( $a ) } grep $_ > 0, @list;
    my @neg    = sort { abs( $b ) <=> abs( $a ) } grep $_ < 0, @list;
    vsay "pos: ", pp @pos;
    vsay "neg: ", pp @neg;

    my @positive_results = (
        @pos >= 3              ? product( @pos[0..2] )          : (),
        @pos >= 1 && @neg >= 2 ? product( @neg[0..1], $pos[0] ) : (),
    );

    # If we have at least one of them, we are done.
    return max( @positive_results )
        if @positive_results;

    # Ok, we are here, so no positive result...
    # To get the 'least negative' result, let's try to limit it to zero.
    # If we have at least one zero in the list, we can multiply it with no
    # matter which other numbers, and we still get a zero result.
    return 0
	if grep $_ == 0, @list;

    # So we need to accept a negative result, using three negative numbers.
    # We choose the ones with the lowest absolute value, giving us the highest
    # (least negative) result possible.
    # (We can be sure that we have at least three negatives, because at this
    # point, we know that
    # * we have more than three numbers (so at least 4),
    # * we have less than three positives (so at most 2),
    # * we don't have any zeroes,
    # so we already have at least 2 negatives.
    # But we also know that if we had at least one positive, we would have
    # combined it with two of our negatives already, so we can't have any
    # positives at all at this point.
    # Leaving us with only negatives (at least 4).
    # So this is the last possible result we need to try.)
    return product( ( reverse @neg )[0..2] )
}

run_tests;

__DATA__

In this description, 'large' means having a higher absolute value.

Test 1: Only positives
Input: @list = ( 2, 3, 5, 7 )
Output: 105

Test 2: Two positives and a zero
Input: @list = ( 2, 3, 0 )
Output: 0

Test 3: Three positives and a zero
Input: @list = ( 2, 3, 5, 0 )
Output: 30

Test 4: Only negatives
Input: @list = ( -2, -3, -5, -7 )
Output: -30

Test 5: Two negatives and a zero
Input: @list = ( -2, -3, 0 )
Output: 0

Test 6: Three negatives and a zero
Input: @list = ( -2, -3, -5, 0 )
Output: 0

Test 7: One 'large' negative and some positives
Input: @list = ( 2, 3, 5, 7, -11 )
Output: 105
We cannot use the large negative.

Test 8: Two 'large' negatives and some positives
Input: @list = ( 2, 3, 5, -7, -11 )
Output: 385

Test 9: Three 'large' negatives and at least one positive
Input: @list = ( 2, 3, 5, -7, -11, -13 )
Output: 715
As long as we have at least one positive value (as small as it might be),
we shouldn't consider the the third largest negative,
because it turns the result into negative.

Test 10: Two positives and one negative.
Input: @list = ( 2, 3, -5 )
Output: -30
