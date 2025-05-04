#!perl

################################################################################
=comment

Perl Weekly Challenge 319
=========================

TASK #2
-------
*Minimum Common*

Submitted by: Mohammad Sajid Anwar

You are given two arrays of integers.

Write a script to return the minimum integer common to both arrays. If none
found return -1.

Example 1

  Input: @array_1 = (1, 2, 3, 4)
         @array_2 = (3, 4, 5, 6)
  Output: 3

  The common integer in both arrays: 3, 4
  The minimum is 3.

Example 2

  Input: @array_1 = (1, 2, 3)
         @array_2 = (2, 4)
  Output: 2

Example 3

  Input: @array_1 = (1, 2, 3, 4)
         @array_2 = (5, 6, 7, 8)
  Output: -1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Since -1 is returned on failure, it may be inferred that the input is limited to
*unsigned* integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line. Each string contains a list of
   whitespace-separated unsigned integers.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( min );
use Regexp::Common qw( number );
use Set::Scalar;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <array_1> <array_2>
  perl $0

    <array_1>    First  string of space-separated unsigned integers
    <array_2>    Second string of space-separated unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 319, Task #2: Minimum Common (Perl)\n\n";
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
        my $array_1 = parse_array( $ARGV[ 0 ] );
        my $array_2 = parse_array( $ARGV[ 1 ] );

        printf "Input:  \@array_1 = (%s)\n", join ', ', @$array_1;
        printf "        \@array_2 = (%s)\n", join ', ', @$array_2;

        my $min_common = find_min_common( $array_1, $array_2 );

        print  "Output: $min_common\n";
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_min_common
#-------------------------------------------------------------------------------
{
    my ($array_1, $array_2) = @_;
    my  $set1   = Set::Scalar->new( @$array_1 );
    my  $set2   = Set::Scalar->new( @$array_2 );
    my  $common = $set1->intersection( $set2 );

    return $common->is_empty ? -1 : min( $common->members );
}

#-------------------------------------------------------------------------------
sub parse_array
#-------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  @elems = split / \s+ /x, $str;
    my  @array;

    for my $elem (@elems)
    {
        $elem =~ / ^ $RE{num}{int} $ /x
                   or error( qq["$elem" is not a valid integer] );

        $elem >= 0 or error( "$elem is negative" );

        push @array, $elem;
    }

    return \@array;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $array_1_str, $array_2_str, $expected) =
             split / \| /x, $line;

        for ($test_name, $array_1_str, $array_2_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $array_1    = parse_array( $array_1_str );
        my $array_2    = parse_array( $array_2_str );
        my $min_common = find_min_common( $array_1, $array_2 );

        is $min_common, $expected, $test_name;
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
Example 1|1 2 3 4|3 4 5 6| 3
Example 2|1 2 3  |2 4    | 2
Example 3|1 2 3 4|5 6 7 8|-1
