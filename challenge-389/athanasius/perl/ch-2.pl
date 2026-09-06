#!perl

################################################################################
=comment

Perl Weekly Challenge 389
=========================

TASK #2
-------
*ZigZag Subarray*

Submitted by: Roger Bell_West

You are given an array of integers.

Write a script to find the length of the longest contiguous subarray where the
numbers alternate between strictly increasing and strictly decreasing (a ZigZag
pattern).

  A sequence of numbers $A = [a0, a1, …, ak]$ with length $k >= 1 is considered
  a ZigZag sequence if every adjacent pair alternates direction:

  a_0 < a_1 > a_2 < a_3 > ...
  OR
  a_0 > a_1 < a_2 > a_3 < ...

NOTE: A single element (length 1) or any two distinct elements (length 2) are automatically valid ZigZag sequences. Equal adjacent numbers (e.g., 5, 5) break the pattern.

Example 1

  Input: @nums = (9, 4, 2, 10, 7, 8, 8, 1, 9)
  Output: 5

  ZigZag subarray: (4, 2, 10, 7, 8)

Example 2

  Input: @nums = (1, 7, 4, 9, 2, 5)
  Output: 6

  ZigZag subarray: (1, 7, 4, 9, 2, 5)

Example 3

  Input: @nums = (1, 2, 3, 4, 5)
  Output: 2

  ZigZag subarray: (1, 2)

Example 4

  Input: @nums = (4, 4, 4)
  Output: 1

Example 5

  Input: @nums = (10, 20, 15, 12, 18)
  Output: 3

  ZigZag subarray: (10, 20, 15)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.
3. The first negative integer, if any, must be preceded by "--" to signal that
   it is not a command-line flag.
4. If either "-v" or "--verbose" is entered as a command-line flag, the required
   output (the length of the longest zigzag subarray) is supplemented with the
   contents of that subarray, as shown in Examples 1, 2, 3, and 5.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-v|--verbose] [<nums> ...]
  perl $0

    [<nums> ...]    A non-empty list of integers
    -v|--verbose    Display the longest zigzag subarray?
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 389, Task #2: ZigZag Subarray (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my $verbose;

        GetOptions( verbose => \$verbose )
            or error( 'Invalid command-line flag' );

        my @nums = @ARGV;

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @nums;

        printf "Input:  \@nums =  (%s)\n", join ', ', @nums;

        my $zigzag = find_longest_zigzag( \@nums );

        printf "Output: %d\n", scalar @$zigzag;
        printf "\nZigZag subarray: (%s)\n", join ', ', @$zigzag if $verbose;
    }
}

#-------------------------------------------------------------------------------
sub find_longest_zigzag
#-------------------------------------------------------------------------------
{
    my ($nums)   = @_;
    my  @longest = $nums->[0];
    my  $str     = 'S';

    for my $i (0 .. $#$nums - 1)
    {
        my $lhs  =  $nums->[$i    ];
        my $rhs  =  $nums->[$i + 1];
           $str .= ($lhs < $rhs) ? 'U' : ($lhs == $rhs) ? 'E' : 'D';
    }

    if ($str =~ / ^ (.*?) ( . [^E] ) /x)
    {
        my $i    = length $1;
        @longest = (@$nums)[$i, $i + 1];
    }

    my $prev_first_idx = $#$nums;

    for my $re (qr/ ^ (.*?) ( . (?: DU )+ D? ) /x,
                qr/ ^ (.*?) ( . (?: UD )+ U? ) /x)
    {
        while ($str =~ /$re/g)
        {
            my $first_idx = length $1;
            my $match_len = length $2;
            my $max_len   = scalar @longest;

            if ($match_len >  $max_len ||
               ($match_len == $max_len && $first_idx < $prev_first_idx))
            {
                my $last_idx    =  $first_idx + $match_len - 1;
                @longest        = (@$nums)[$first_idx .. $last_idx];
                $prev_first_idx =  $first_idx;
            }
        }
    }

    return \@longest;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $nums_str, $exp_length, $exp_zigzag_str) =
             split / \| /x, $line;

        for ($test_name, $nums_str, $exp_length, $exp_zigzag_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @nums       = split / \s+ /x, $nums_str;
        my $zigzag     = find_longest_zigzag( \@nums );
        my @exp_zigzag = split / \s+ /x, $exp_zigzag_str;

        is scalar @$zigzag,  $exp_length, "$test_name: length";
        is_deeply  $zigzag, \@exp_zigzag, "$test_name: subarray";
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
Example 1| 9  4  2 10  7 8 8 1 9|5| 4  2 10 7 8
Example 2| 1  7  4  9  2 5      |6| 1  7  4 9 2 5
Example 3| 1  2  3  4  5        |2| 1  2
Example 4| 4  4  4              |1| 4
Example 5|10 20 15 12 18        |3|10 20 15
