#!perl

################################################################################
=comment

Perl Weekly Challenge 318
=========================

TASK #2
-------
*Reverse Equals*

Submitted by: Roger Bell_West

You are given two arrays of integers, each containing the same elements as the
other.

Write a script to return true if one array can be made to equal the other by
reversing exactly one contiguous subarray.

Example 1

  Input: @source = (3, 2, 1, 4)
         @target = (1, 2, 3, 4)
  Output: true

  Reverse elements: 0-2

Example 2

  Input: @source = (1, 3, 4)
         @target = (4, 1, 3)
  Output: false

Example 3

  Input: @source = (2)
         @target = (2)
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line. Each is a whitespace-separated
   list of integers. The second ("target") list contains the same elements as
   the first ("source") list, but not necessarily in the same order.

Notes
-----
1. If the target array is not a permutation of the source array, then of course
   the arrays cannot be made equal by reversing a subarray. So it would make
   sense to simply return "false" in this case. However, as the Task specifies
   that the two arrays contain the same elements, input of two arrays which are
   not permutations of each other is here treated as an error.
2. If the input arrays are empty, there is nothing to be reversed, so there
   cannot be "exactly one" subarray reversed. In this case, "false" is returned.
3. If the two arrays are identical, and of length n, then there are n ways in
   which a subarray of length one can be "reversed" to leave them identical. In
   this case, "reversal" of the subarray from index 0 to 0 (i.e., of the first
   character) is given as the solution.
4. If the arrays differ at exacly one character, no solution is possible.
5. In all other cases, if a solution is possible then the subarray to be
   reversed must extend from the first (left-most) non-identical character to
   the last (right-most) non-identical character.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Array::Compare;
use Const::Fast;
use Devel::Assert  qw( on );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <source> <target>
  perl $0

    <source>    Source string of whitespace-separated integers
    <target>    Target string of whitespace-separated integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 318, Task #2: Reverse Equals (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 2)
    {
        my $source = parse_input( $ARGV[ 0 ] );
        my $target = parse_input( $ARGV[ 1 ] );
        my $comp   = Array::Compare->new;

        $comp->perm( $source, $target )
            or error( 'The input list elements differ' );

        printf "Input:  \@source = (%s)\n", join ', ', @$source;
        printf "        \@target = (%s)\n", join ', ', @$target;

        my ($start, $end) = reverse_equals( $source, $target );

        if ($start >= 0 && $end >= 0)
        {
            print "Output: true\n\nReverse elements: $start-$end\n";
        }
        else
        {
            print "Output: false\n";
        }
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub reverse_equals
#-------------------------------------------------------------------------------
{
    my ($source, $target) = @_;
    my  $comp = Array::Compare->new;

    assert scalar @$source == scalar @$target;
    assert $comp->perm( $source, $target );

    return -1, -1 if scalar @$source == 0;
    return  0,  0 if $comp->simple_compare( $source, $target );

    my ($start, $end);

    for my $i (        0 .. $#$source)
    {
        $start = $i, last if $source->[ $i ] != $target->[ $i ];
    }

    for my $j (reverse 0 .. $#$source)
    {
        $end   = $j, last if $source->[ $j ] != $target->[ $j ];
    }

    return $start,  $end
        if $start < $end &&
           $comp->simple_compare( [ reverse @$source[ $start .. $end ] ],
                                  [         @$target[ $start .. $end ] ] );

    return -1, -1;
}

#-------------------------------------------------------------------------------
sub parse_input
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  @ints;

    for my $elem (grep { length } split / \s+ /x, $str)
    {
        $elem =~ / ^ $RE{num}{int} $ /x or error( qq[Invalid integer "$elem"] );

        push @ints, $elem;
    }

    return \@ints;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $source_str, $target_str, $exp_start, $exp_end) =
             split / \| /x, $line;

        for ($test_name, $source_str, $target_str, $exp_start, $exp_end)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my  $source       = parse_input( $source_str );
        my  $target       = parse_input( $target_str );
        my ($start, $end) = reverse_equals( $source, $target );

        ok  $start == $exp_start && $end == $exp_end, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|3 2 1 4|1 2 3 4| 0| 2
Example 2|1 3 4  |4 1 3  |-1|-1
Example 3|2      |2      | 0| 0
Empty    |       |       |-1|-1
Same 1   |1 2 3 4|1 2 3 4| 0| 0
Same 2   |7 7 7  |7 7 7  | 0| 0
Whole    |1 2 3 4|4 3 2 1| 0| 3
Left     |1 2 3 4|3 2 1 4| 0| 2
Right    |1 2 3 4|1 4 3 2| 1| 3
Centre   |1 2 3 4|1 3 2 4| 1| 2
