#!perl

###############################################################################
=comment

Perl Weekly Challenge 083
=========================

Task #2
-------
*Flip Array*

Submitted by: Mohammad S Anwar

You are given an array @A of positive numbers.

Write a script to flip the sign of some members of the given array so that the
sum of the all members is minimum non-negative.

Given an array of positive elements, you have to flip the sign of some of its
elements such that the resultant sum of the elements of array should be minimum
non-negative (as close to zero as possible). Return the minimum no. of elements
whose sign needs to be flipped such that the resultant sum is minimum non-
negative.

Example 1:

 Input: @A = (3, 10, 8)
 Output: 1

Explanation:

 Flipping the sign of just one element 10 gives the result 1 i.e. (3) + (-10) +
 (8) = 1

Example 2:

 Input: @A = (12, 2, 10)
 Output: 1

Explanation:

 Flipping the sign of just one element 12 gives the result 0 i.e. (-12) + (2) +
 (10) = 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions:
1.  The input array is non-empty.
2.  A "positive number" here means an integer greater than zero.
3.  Both the final sum and the flip count are to be minimised, but minimising
    the final sum (i.e., the sum after some of the numbers have been flipped)
    takes priority over minimising the count of numbers to be flipped.

Algorithm:
    Brute force (i.e., exhaustive inspection of possible combinations), using
    Algorithm::Combinatorics::subsets(). Note that this is inefficient for bags
    (multisets) because repeated elements result in repeated, identical, sub-
    sets (combinations). (This drawback is shared by the List::PowerSet and
    Data::PowerSet modules.)

=cut
#==============================================================================

                                                # Exports:
use strict;
use warnings;
use Algorithm::Combinatorics qw( subsets );
use Const::Fast;                                # const()
use List::Util               qw( sum0 );
use Regexp::Common           qw( number );      # %RE{num}
use constant EXPLAIN => 1;

const my $USAGE =>
"Usage:
  perl $0 [<A> ...]

    [<A> ...]    A non-empty array of positive integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 083, Task #2: Flip Array (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @A = parse_command_line();

    printf "  Input:  \@A = (%s)\n", join ', ', @A;

    my $total_sum       = sum0 @A;
    my $min_flipped_sum = $total_sum;
    my @nums_to_flip;

    my $iter = subsets(\@A);

    while (my $comb = $iter->next)
    {
        next if scalar @$comb == 0 ||
                scalar @$comb == scalar @A;

        my $comb_sum    = sum0 @$comb;
        my $flipped_sum = $total_sum - 2 * $comb_sum;

        next if $flipped_sum < 0;

        if    ($flipped_sum <  $min_flipped_sum)
        {
            $min_flipped_sum = $flipped_sum;
            @nums_to_flip    = @$comb;
        }
        elsif ($flipped_sum == $min_flipped_sum &&
               scalar @$comb <  scalar @nums_to_flip)
        {
            @nums_to_flip    = @$comb;
        }
    }

    my $nums_to_flip = scalar @nums_to_flip;

    print "  Output: $nums_to_flip\n";

    if (EXPLAIN)
    {
        print  "\nExplanation:\n";
        printf "  Flipping the sign of %d element%s %sgives the result %d\n",
            $nums_to_flip,
            $nums_to_flip == 1 ? '' : 's',
            $nums_to_flip == 0 ? '' : '(' . join(', ', @nums_to_flip) . ') ',
            $min_flipped_sum;
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    scalar @ARGV > 0
                or  die qq[ERROR: No command-line arguments\n]        . $USAGE;

    for (@ARGV)
    {
        / \A $RE{num}{int} \z /x
                or  die qq[ERROR: Non-integer "$_"\n]                 . $USAGE;
        $_ <  0 and die qq[ERROR: Negative integer "$_"\n]            . $USAGE;
        $_ == 0 and die qq[ERROR: Zero is not a "positive" integer\n] . $USAGE;
    }

    return @ARGV;
}

###############################################################################
