#!perl

###############################################################################
=comment

Perl Weekly Challenge 201
=========================

TASK #2
-------
*Penny Piles*

Submitted by: Robbie Hatley

You are given an integer, $n > 0.

Write a script to determine the number of ways of putting $n pennies in a row
of piles of ascending heights from left to right.

Example

  Input: $n = 5
  Output: 7

  Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:

      1 1 1 1 1
      1 1 1 2
      1 2 2
      1 1 3
      2 3
      1 4
      5

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. If $VERBOSE is set to a true value, then, providing $n is sufficiently small
   (i.e., less than or equal to $MAX_N_ENUM), the output is followed by an
   enumeration of the different possible partitions, as per the Example.

Output Order
------------
Following the Example, partitions are ordered by number of piles, descending.
Partitions with the same number of piles are ordered by the size (height) of
the largest pile, ascending. Within each partition, piles are ordered by size,
ascending.

Solution
--------
The required solution is given by the partition function [1], an integer
sequence [3] for which "No closed-form expression ... is known" but for which
there are "recurrence relations by which it can be calculated exactly." [1]

Rather than reinvent the wheel, I have chosen to use the CPAN module "Math::
Prime::Util" [2] (also known as "ntheory") to perform the calculations:

  1. if only the count of partitions is required, the subroutine Math::Prime::
     Util::partitions() is used for maximum efficiency;
  2. if an enumeration of the partitions is required, the subroutine Math::
     Prime::Util::forpart() is used instead.

See my Raku solution to Task 2 for a recursive approach that utilises Euler's
recurrence relation. This latter solution, which uses no external modules, is
much less efficient.

References
----------
[1] "Partition function (number theory)", Wikipedia,
     https://en.wikipedia.org/wiki/Partition_function_(number_theory)
[2] "partitions", Math::Prime::Util,
     https://metacpan.org/pod/Math::Prime::Util#partitions
[3]  Sequence A000041, The On-Line Encyclopedia of Integer Sequences,
     https://oeis.org/A000041

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util        qw( max );
use Math::Prime::Util qw( forpart partitions );
use Regexp::Common    qw( number );
use Test::More;

const my $VERBOSE     =>  1;
const my $MAX_N_ENUM  => 13;
const my $TEST_FIELDS =>  3;
const my $USAGE       =>
"Usage:
  perl $0 <n>
  perl $0

    <n>    A positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 201, Task #2: Penny Piles (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        my $n = $ARGV[ 0 ];
           $n =~ / ^ $RE{num}{int} $ /x
                or error( qq["$n" is not a valid integer] );

        print  "Input:  \$n = $n\n";

        if ($VERBOSE && $n <= $MAX_N_ENUM)
        {
            my $penny_piles = find_penny_piles( $n );
            my $count       = scalar @$penny_piles;

            printf "Output: %d\n\nThere are %d ways of stacking %d pennies " .
                   "in ascending piles:\n\n    %s\n", $count, $count, $n,
                    join( "\n    ", map { join ' ', @$_ } @$penny_piles );
        }
        else
        {
            printf "Output: %d\n", count_penny_piles( $n );
        }
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub count_penny_piles
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    return partitions( $n );
}

#------------------------------------------------------------------------------
sub find_penny_piles
#------------------------------------------------------------------------------
{
    my ($n) = @_;
    my  @penny_piles;

    forpart
    {
        push @penny_piles, [ @_ ]

    } $n;

    @penny_piles = sort
                   {
                       scalar @$b   <=> scalar @$a ||
                         max( @$a ) <=>   max( @$b )

                   } @penny_piles;

    return \@penny_piles;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $n, $expected) = split / \| /x, $line, $TEST_FIELDS;

        $n =~ s/ ^ \s* (.+?) \s* $ /$1/x;                     # Trim whitespace

        is count_penny_piles( $n ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example   | 5|7
Smallest  | 1|1
Small     |13|101
Medium    |22|1002
Large     |33|10143
Very large|41|44583
Huge      |70|4087968
