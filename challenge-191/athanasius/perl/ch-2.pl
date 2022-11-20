#!perl

###############################################################################
=comment

Perl Weekly Challenge 191
=========================

TASK #2
-------
*Cute List*

Submitted by: Mohammad S Anwar

You are given an integer, 0 < $n <= 15.

Write a script to find the number of orderings of numbers that form a cute
list.

With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of
@list is cute if for every entry, indexed with a base of 1, either

  1) $list[$i] is evenly divisible by $i
  or
  2) $i is evenly divisible by $list[$i]

Example

  Input: $n = 2
  Output: 2

  Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.
  Therefore we can have two list i.e. (1,2) and (2,1).

  @list = (1,2) is cute since $list[1] = 1 is divisible by 1 and $list[2] = 2
  is divisible by 2.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. Set $TIMER to a true value to display the total time taken.

Assumption
----------
There are 15 possible inputs, each with a pre-computable output. Therefore, the
most efficient "solution" to this Task would be a simple lookup table. However,
as that would be trivial, I assume that what is wanted is a script to *calcu-
late* solutions efficiently.

Algorithm
---------
The total number of permutations of integers 1 to n is n!, which renders a
brute force search impractical for values of n above around 11 (11! is almost
40 million). The following table shows the potential maximum search space (n!)
for n in the range 1 to 15; also shown is f(n), "the number of orderings of
numbers that form a cute list", i.e., the correct solution for each n:

        ---------------------------------
           n    f(n)                 n!
        ---------------------------------
           1       1                  1
           2       2                  2
           3       3                  6
           4       8                 24
           5      10                120
           6      36                720
           7      41              5,040
           8     132             40,320
           9     250            362,880
          10     700          3,628,800
          11     750         39,916,800
          12   4,010        479,001,600
          13   4,237      6,227,020,800
          14  10,680     87,178,291,200
          15  24,679  1,307,674,368,000
        ---------------------------------

It is therefore necessary to drastically reduce the search space. This is
accomplished by the following algorithm:

1. A count of "cute" list orderings is initialised to zero.
2. For each index (list position, 1 to n, in the ordering), a list is computed
   of the numbers (again, drawn from 1 to n) which can satisfy the "cuteness"
   conditions while appearing at that index; these are the "options" for that
   position.
3. The position with the fewest number of options is selected.
4. For each of those options p:
   4.1 p is removed from the lists of remaining options
   4.2 Steps 3 and 4 are repeated recursively with the reduced option set until
       either:
       - the options for a particular index reduce to zero, in which case this
         branch of the recursive search is truncated; or
       - all list positions are filled, in which case the recursive search ends
         and the count is incremented.
5. The count is output as the required solution.

Performance
-----------
On my machine (Intel Core2 Duo T5850 @ 2.1 GHz, running Windows 8.1 64-bit and
Strawberry Perl 5.32.1), the test suite completes in under 4 seconds.

=cut
#==============================================================================

use strict;
use warnings;
use Clone          qw( clone );
use Const::Fast;
use List::Util     qw( first min );
use Regexp::Common qw( number );
use Test::More;
use constant TIMER    =>  1;
use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );

const my $MAX_N       => 15;
const my $TEST_FIELDS =>  3;
const my $USAGE       =>
"Usage:
  perl $0 <n>
  perl $0

    <n>    An integer in the range 1 to $MAX_N\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 191, Task #2: Cute List (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $t0   = [ gettimeofday ] if TIMER;
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        my $n = $ARGV[ 0 ];

        $n =~ / ^ $RE{num}{int} $ /x
            or error( qq["$n is not a valid integer] );

        0 < $n <= $MAX_N
            or error( qq["$n" is not in the range 1 to $MAX_N] );

        print  "Input:  \$n = $n\n";
        printf "Output: %d\n", count_cute_lists( $n );
    }
    else
    {
        error( "Expected 0 or 1 arguments, found $args" );
    }

    my $t  = tv_interval( $t0 ) if TIMER;
    print  "\n$t seconds\n"     if TIMER;
}

#------------------------------------------------------------------------------
sub count_cute_lists
#------------------------------------------------------------------------------
{
    my ($n) = @_;
    my  %options;          # Both numbers-per-position and positions-per-number

    for my $i (1 .. $n)
    {
        for my $j (1 .. $n)
        {
            push @{ $options{ $i } }, $j if $i % $j == 0 ||
                                            $j % $i == 0;
        }
    }

    return count_recursive( \%options );
}

#------------------------------------------------------------------------------
sub count_recursive
#------------------------------------------------------------------------------
{
    my ($options) = @_;
    my  $count    = 0;

    if (scalar (my @keys = keys %$options) == 1)                    # Base case
    {
        ++$count;                               # This solution is now complete
    }
    else
    {
        my $key = choose_next_key( $options );        # Key with fewest options

        OP: for my $op (@{ $options->{ $key } })
        {
            my %my_options = %{ clone( $options ) };         # Make a deep copy

            delete $my_options{ $key };                      # Simplifying step

            for my $k (keys %my_options)
            {
                my @ops; # Remove each occurrence of $op from remaining options
                $_ == $op or push @ops, $_ for @{ $my_options{ $k } };

                next OP if scalar @ops == 0;             # Truncate this branch
                                                         # of the decision tree
                $my_options{ $k } = \@ops;
            }

            $count += count_recursive( \%my_options );         # Recursive case
        }
    }

    return $count;
}

#------------------------------------------------------------------------------
sub choose_next_key
#------------------------------------------------------------------------------
{
    # Choose the (first) key with the MINIMUM number of options:
    # this produces a significant speed-up

    my ($h_ref) = @_;
    my  @keys   = keys %$h_ref;
    my  $min    = min map { scalar @{ $h_ref->{ $_ } } } @keys;

    return  first { $min == scalar @{ $h_ref->{ $_ } } } @keys;
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

        my ($test_name, $n, $expected) =
            split / , \s* /x, $line, $TEST_FIELDS;

        is count_cute_lists( $n ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
One,       1,     1
Two,       2,     2
Three,     3,     3
Four,      4,     8
Five,      5,    10
Six,       6,    36
Seven,     7,    41
Eight,     8,   132
Nine,      9,   250
Ten,      10,   700
Eleven,   11,   750
Twelve,   12,  4010
Thirteen, 13,  4237
Fourteen, 14, 10680
Fifteen,  15, 24679
