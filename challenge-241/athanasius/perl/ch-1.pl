#!perl

################################################################################
=comment

Perl Weekly Challenge 241
=========================

TASK #1
-------
*Arithmetic Triplets*

Submitted by: Mohammad S Anwar

You are given an array (3 or more members) of integers in increasing order and a
positive integer.

Write a script to find out the number of unique Arithmetic Triplets satisfying
the following rules:

  a) i < j < k
  b) nums[j] - nums[i] == diff
  c) nums[k] - nums[j] == diff

Example 1

  Input: @nums = (0, 1, 4, 6, 7, 10)
         $diff = 3
  Output: 2

  Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 ==
  3.
  Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 ==
  3.

Example 2

  Input: @nums = (4, 5, 6, 7, 8, 9)
         $diff = 2
  Output: 2

  (0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.
  (1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, the required output is followed by a list
   of the arithmetic triplets found.
3. If the first (non-difference) integer is negative, it must be preceded by
   "--" to indicate that it is not a command-line flag.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [--diff] [<nums> ...]
  perl $0

    --diff          Difference (integer > 0)
    [<nums> ...]    A list of 3 or more integers in increasing order\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 241, Task #1: Arithmetic Triplets (Perl)\n\n";
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
        my ($nums, $diff) = parse_command_line();

        printf "Input:  \@nums = (%s)\n", join ', ', @$nums;
        print  "        \$diff =  $diff\n";

        my $triplets = find_triplets( $nums, $diff );
        my $count    = scalar @$triplets;

        print "Output: $count\n";

        if ($VERBOSE && $count > 0)
        {
            printf "\nArithmetic triplet%s: %s\n",
                $count == 1 ? '' : 's',
                join ', ', map { '(' . join( ', ', @$_ ) . ')' } @$triplets;
        }
    }
}

#-------------------------------------------------------------------------------
sub find_triplets
#-------------------------------------------------------------------------------
{
    my ($nums, $diff) = @_;
    my  @triplets;

    L_OUTER: for my $i (0 .. $#$nums - 2)
    {
        for my $j ($i + 1 .. $#$nums - 1)
        {
            if ((my $ji_diff = $nums->[ $j ] - $nums->[ $i ]) == $diff)
            {
                for my $k ($j + 1 .. $#$nums)
                {
                    if ((my $kj_diff = $nums->[ $k ] - $nums->[ $j ]) == $diff)
                    {
                        push @triplets, [ $i, $j, $k ];
                        next L_OUTER;
                    }
                    elsif ($kj_diff > $diff)
                    {
                        next L_OUTER;
                    }
                }
            }
            elsif ($ji_diff > $diff)
            {
                next L_OUTER;
            }
        }
    }

    return \@triplets;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $diff;

    GetOptions( 'diff=i' => \$diff )
              or error( 'Invalid command line argument' );

    defined $diff
              or error( 'Difference is missing' );


    $diff =~/ ^ $RE{num}{int} $ /x
              or error( qq[Difference "$diff" is not a valid integer] );

    $diff > 0 or error( qq[Difference "$diff" is not a positive integer] );

    my @nums = @ARGV;

    for (@nums)
    {
        / ^ $RE{num}{int} $ /x
              or error( qq["$_" is not a valid integer] );
    }

    scalar @nums >= 3
              or error( 'Too few input integers' );

    increasing_order( \@nums )
              or error( 'The input integers are not in increasing order' );

    return (\@nums, $diff);
}

#-------------------------------------------------------------------------------
sub increasing_order
#-------------------------------------------------------------------------------
{
    my ($nums) = @_;

    for my $i (1 .. $#$nums)
    {
        return 0 unless $nums->[ $i ] > $nums->[ $i - 1 ];
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $num_str, $diff, $expected) = split / \| /x, $line;

        for ($test_name, $num_str, $diff, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @nums     = split / \s+ /x, $num_str;
        my $triplets = find_triplets( \@nums, $diff );

        is scalar @$triplets, $expected, $test_name;
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
Example 1| 0  1  4 6 7 10      |3|2
Example 2| 4  5  6 7 8  9      |2|2
Negatives|-5 -4 -1 0 1  3 4 5 7|4|3
