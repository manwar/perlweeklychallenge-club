#!perl

################################################################################
=comment

Perl Weekly Challenge 261
=========================

TASK #2
-------
*Multiply by Two*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer $start..

Write a script to do the followings:

  a) Look for $start in the array @ints, if found multiply the number by 2
  b) If not found stop the process otherwise repeat

In the end return the final value.

Example 1

  Input: @ints = (5,3,6,1,12) and $start = 3
  Output: 24

  Step 1: 3 is in the array so 3 x 2 = 6
  Step 2: 6 is in the array so 6 x 2 = 12
  Step 3: 12 is in the array so 12 x 2 = 24

  24 is not found in the array so return 24.

Example 2

  Input: @ints = (1,2,4,3) and $start = 1
  Output: 8

  Step 1: 1 is in the array so 1 x 2 = 2
  Step 2: 2 is in the array so 2 x 2 = 4
  Step 3: 4 is in the array so 4 x 2 = 8

  8 is not found in the array so return 8.

Example 3

  Input: @ints = (5,6,7) and $start = 2
  Output: 2

  2 is not found in the array so return 2.

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
2. The starting integer is given on the command-line as a named argument,
   followed by a (possibly empty) list of integers.
3. If any integers in the list (i.e., following the start integer) on the
   command-line are either negative or preceded by an explicit "+" sign, the
   list must be preceded by "--" to indicate that the signed integers are not
   command-line flags.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util     qw( any );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [--start[=Int]] [<ints> ...]
  perl $0

    --start[=Int]    The starting integer
    [<ints> ...]     A list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 261, Task #2: Multiply by Two (Perl)\n\n";
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
        my ($start, $ints) = parse_command_line();

        printf "Input:  \@ints = (%s) and start = %d\n",
                join( ',', @$ints ), $start;

        printf "Output: %d\n", find_final_value( $ints, $start );
    }
}

#-------------------------------------------------------------------------------
sub find_final_value
#-------------------------------------------------------------------------------
{
    my ($ints, $start) = @_;

    my  $value = $start;

    if ($start != 0)
    {
        $value *= 2 while any { $_ == $value } @$ints;
    }

    return $value;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $start;

    GetOptions( 'start=i' => \$start )
                        or error( 'Invalid command-line argument' );

    defined $start      or error( '$start is missing' );
    
    $start =~ / ^ $RE{num}{int} $ /x
                        or error( qq[start ("$start") is not a valid integer] );

    my @ints = @ARGV;

    for (@ints)
    {
        / ^ $RE{num}{int} $ /x
                        or error( qq["$_" is not a valid integer] );
    }

    return ($start, \@ints);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $start, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $start, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints  = split / \s+ /x, $ints_str;
        my $value = find_final_value( \@ints, $start );

        is $value, $expected, $test_name;
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
Example 1  |5  3  6  1 12  | 3|24
Example 2  |1  2  4  3     | 1| 8
Example 3  |5  6  7        | 2| 2
Negatives  |7 -2  0 -1  3  |-1|-4
Repetitions|4  8 16  4 32 8| 4|64
Zero start |9 -3  1 17  0  | 0| 0
Empty list |               |42|42
