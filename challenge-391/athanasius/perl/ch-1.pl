#!perl

################################################################################
=comment

Perl Weekly Challenge 391
=========================

TASK #1
-------
*Array Median*

Submitted by: Mohammad Sajid Anwar

You are given two sorted arrays.

Write a script to merge the two given sorted arrays and return the median of the
merged array.

Example 1

  Input: @arr1 = (2), @arr2 = (4)
  Output: 3.0

  Merged array: (2,4)
  Median: (2+4)/2 => 3

Example 2

  Input: @arr1 = (1,2,3), @arr2 = (7,8,9,10)
  Output: 7.0

  Merged array: (1,2,3,7,8,9,10)
  Length of merged array is 7, the 4th element is 7.

Example 3

  Input: @arr1 = (), @arr2 = (10,20,30,40)
  Output: 25.0

  Merged array: (10,20,30,40)
  Median: (20+30)/2 => 25

Example 4

  Input: @arr1 = (100), @arr2 = (1,2,3,4,5,6,7)
  Output: 4.5

  Merged array: (1,2,3,4,5,6,7,100)
  Median: (4+5)/2 => 4.5

Example 5

  Input: @arr1 = (1,2,2), @arr2 = (2,2,3)
  Output: 2.0

  Merged array: (1,2,2,2,2,3)
  Median: (2+2)/2 => 2

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Elements of the input lists are integers.
2. An input array may be empty (see Example 3); but if both input arrays are
   empty, no median is defined. In this case, the result is displayed as
   "Output: <none>".

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings, each containing a sorted list of comma-separated integers, are
   entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use boolean;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    An encoded string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 391, Task #1: Array Median (Perl)\n\n";
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
        my ($arr1, $arr2) = parse_input( @ARGV );

        printf "Input:  \@arr1 = (%s), \@arr2 = (%s)\n",
                join( ',', @$arr1 ), join( ',', @$arr2 );

        my $median = find_median( $arr1, $arr2 );

        print "Output: $median\n";
    }
    else
    {
        error( "Expected 0 or 2 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_median
#-------------------------------------------------------------------------------
{
    my  ($arr1, $arr2) = @_;
    my   $median;
    my   @merged  = @$arr1;
    push @merged,   @$arr2;
         @merged  = sort { $a <=> $b } @merged;
    my   $count   = scalar @merged;

    if ($count > 0)
    {
        my $i   = int( $#merged / 2 );
        $median = ($count % 2 == 0) ? ($merged[$i] + $merged[$i + 1]) / 2
                                    :  $merged[$i];
    }

    return defined $median ? sprintf( '%.1f', $median ) : '<none>';
}

#-------------------------------------------------------------------------------
sub parse_input
#-------------------------------------------------------------------------------
{
    my ($arr1, $arr2) = @_;
    my (@arr1, @arr2);

    for my $n (split / , /x, $arr1)
    {
        $n =~ / ^ $RE{num}{int} $ /x
              or error( qq["$n" is not a valid integer] );
        push @arr1, $n;
    }

    is_sorted( \@arr1 ) or error( '@arr1 is not sorted' );

    for my $n (split / , /x, $arr2)
    {
        $n =~ / ^ $RE{num}{int} $ /x
              or error( qq["$n" is not a valid integer] );
        push @arr2, $n;
    }

    is_sorted( \@arr2 ) or error( '@arr2 is not sorted' );

    return (\@arr1, \@arr2);
}

#-------------------------------------------------------------------------------
sub is_sorted
#-------------------------------------------------------------------------------
{
    my ($array) = @_;

    for my $i (0 .. $#$array - 1)
    {
        return false if $array->[$i] > $array->[$i + 1];
    }

    return true;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $arr1_str, $arr2_str, $expected) =
             split / \| /x, $line;

        for ($test_name, $arr1_str, $arr2_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($array1, $array2) = parse_input( $arr1_str, $arr2_str );

        my  $median = find_median( $array1, $array2 );

        is  $median, $expected, $test_name;
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
Example 1|2    |4            | 3.0
Example 2|1,2,3|7,8,9,10     | 7.0
Example 3|     |10,20,30,40  |25.0
Example 4|100  |1,2,3,4,5,6,7| 4.5
Example 5|1,2,2|2,2,3        | 2.0
Empty    |     |             |<none>
