#!perl

################################################################################
=comment

Perl Weekly Challenge 262
=========================

TASK #1
-------
*Max Positive Negative*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the maximum number of either positive or negative
integers in the given array.

Example 1

  Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
  Output: 4

  Count of positive integers: 4
  Count of negative integers: 3
  Maximum of count of positive and negative integers: 4

Example 2

  Input: @ints = (-1, -2, -3, 1)
  Output: 3

  Count of positive integers: 1
  Count of negative integers: 3
  Maximum of count of positive and negative integers: 3

Example 3

  Input: @ints = (1,2)
  Output: 2

  Count of positive integers: 2
  Count of negative integers: 0
  Maximum of count of positive and negative integers: 2

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Duplicate integers are counted as often as they appear.
   This may be overridden by including the flag "--unique" on the command-line.
2. The number 0 (zero) is positive.
   This may be overridden by including the flag "--skip_0" on the command-line.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. One or more integers are given as arguments on the command-line.
3. If any integer in the list on the command-line is negative, the first such
   integer must be preceded by "--" to indicate that what follows does not
   contain command-line flags.
4. If the constant VERBOSE is set to True, the assumptions under which the
   result is calculated are displayed along with the input integers.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util     qw( max uniqint );
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
Usage:
  perl $0 [--unique] [--skip_0] [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of integers
    --unique        Count unique ints only (ignore duplicates)  [default: False]
    --skip_0        Consider zero neither positive nor negative [default: False]
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 262, Task #1: Max Positive Negative (Perl)\n\n";
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
        my ($ints, $unique, $skip_0) = parse_command_line();

        printf "Input:  \@ints = (%s)\n", join ',', @$ints;

        if ($VERBOSE)
        {
            printf "        Count %s\n",
                    $unique ? 'unique integers only (ignore duplicates)'
                            : 'all integers, including duplicates';

            printf "        Consider zero as %s\n",
                    $skip_0 ? 'neither positive nor negative'
                            : 'positive';
        }

        my $max = find_max_pos_neg( $ints, $unique, $skip_0 );

        print  "Output: $max\n";
    }
}

#-------------------------------------------------------------------------------
sub find_max_pos_neg
#-------------------------------------------------------------------------------
{
    my ($ints, $unique, $skip_0) = @_;
    my  $neg_count = 0;
    my  $pos_count = 0;
    my  @integers  = $unique ? uniqint( @$ints ) : @$ints;

    for my $n (@integers)
    {
        if    ($n < 0)
        {
            ++$neg_count;
        }
        elsif ($n > 0 || ($n == 0 && !$skip_0))
        {
            ++$pos_count;
        }
    }

    return max( $neg_count, $pos_count );
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($unique, $skip_0);

    GetOptions
    (
        'unique' => \$unique,
        'skip_0' => \$skip_0,

    ) or error( 'Invalid command line argument(s)' );

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
    }

    return (\@ARGV, $unique, $skip_0);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected, $unique, $skip_0) =
             split / \| /x, $line;

        for ($test_name, $ints_str, $expected, $unique, $skip_0)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $max  = find_max_pos_neg( \@ints, $unique, $skip_0 );

        is $max, $expected, $test_name;
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
Example 1   |-3  1  2 -1 3 -2  4|4|0|0
Example 2   |-1 -2 -3  1        |3|0|0
Example 3   | 1  2              |2|0|0
Duplicates 1| 1 -2  1 -3 2  1 -4|3|1|0
Duplicates 2| 1 -2  1 -3 2  1 -4|4|0|0
Zeros 1     | 4  0 -3 -2 1 -4  0|4|0|0
Zeros 2     | 4  0 -3 -2 1 -4  0|3|0|1
