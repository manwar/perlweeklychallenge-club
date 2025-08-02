#!perl

################################################################################
=comment

Perl Weekly Challenge 269
=========================

TASK #2
-------
*Distribute Elements*

Submitted by: Mohammad Sajid Anwar

You are given an array of distinct integers, @ints.

Write a script to distribute the elements as described below:

  1) Put the 1st element of the given array to a new array @arr1.
  2) Put the 2nd element of the given array to a new array @arr2.

Once you have one element in each arrays, @arr1 and @arr2, then follow the rule
below:

  If the last element of the array @arr1 is greater than the last
  element of the array @arr2 then add the first element of the
  given array to @arr1 otherwise to the array @arr2.

When done distribution, return the concatenated arrays. @arr1 and @arr2.

Example 1

  Input: @ints = (2, 1, 3, 4, 5)
  Output: (2, 3, 4, 5, 1)

  1st operation:
  Add 1 to @arr1 = (2)

  2nd operation:
  Add 2 to @arr2 = (1)

  3rd operation:
  Now the last element of @arr1 is greater than the last element
  of @arr2, add 3 to @arr1 = (2, 3).

  4th operation:
  Again the last element of @arr1 is greate than the last element
  of @arr2, add 4 to @arr1 = (2, 3, 4)

  5th operation:
  Finally, the last element of @arr1 is again greater than the last
  element of @arr2, add 5 to @arr1 = (2, 3, 4, 5)

  Mow we have two arrays:
  @arr1 = (2, 3, 4, 5)
  @arr2 = (1)

  Concatenate the two arrays and return the final array: (2, 3, 4, 5, 1).

Example 2

  Input: @ints = (3, 2, 4)
  Output: (3, 4, 2)

  1st operation:
  Add 1 to @arr1 = (3)

  2nd operation:
  Add 2 to @arr2 = (2)

  3rd operation:
  Now the last element of @arr1 is greater than the last element
  of @arr2, add 4 to @arr1 = (3, 4).

  Now we have two arrays:
  @arr1 = (3, 4)
  @arr2 = (2)

  Concatenate the two arrays and return the final array: (3, 4, 2).

Example 3

  Input: @ints = (5, 4, 3, 8)
  Output: (5, 3, 4, 8)

  1st operation:
  Add 1 to @arr1 = (5)

  2nd operation:
  Add 2 to @arr2 = (4)

  3rd operation:
  Now the last element of @arr1 is greater than the last element
  of @arr2, add 3 to @arr1 = (5, 3).

  4th operation:
  Again the last element of @arr2 is greate than the last element
  of @arr1, add 8 to @arr2 = (4, 8)

  Now we have two arrays:
  @arr1 = (5, 3)
  @arr2 = (4, 8)

  Concatenate the two arrays and return the final array: (5, 3, 4, 8).

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input integers are entered on the command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of distinct integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 269, Task #2: Distribute Elements (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @ints = @ARGV;

        check_input( \@ints );

        printf "Input: \@ints = (%s)\n", join ', ', @ints;

        my $soln = distribute_elements( \@ints );

        printf "Output:        (%s)\n",  join ', ', @$soln;
    }
}

#-------------------------------------------------------------------------------
sub distribute_elements
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @arr1  = shift @$ints;
    my  @arr2  = shift @$ints if @$ints;

    while (@$ints)
    {
        my $target = $arr1[ -1 ] > $arr2[ -1 ] ? \@arr1 : \@arr2;

        push @$target, shift @$ints;
    }

    push @arr1, @arr2;

    return \@arr1;
}

#-------------------------------------------------------------------------------
sub check_input
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  %dict;

    for (@$ints)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );

        ++$dict{ $_ } == 1     or error( 'Duplicate found' );
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expd_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $expd_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;

        check_input( \@ints );

        my $soln = distribute_elements( \@ints );
        my @expd = split / \s+ /x, $expd_str;

        is_deeply $soln, \@expd, $test_name;
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
Example 1| 2 1  3 4 5| 2 3 4  5 1
Example 2| 3 2  4    | 3 4 2
Example 3| 5 4  3 8  | 5 3 4  8
Singleton|17         |17
Negatives|-1 1 -2 2  |-1 2 1 -2
