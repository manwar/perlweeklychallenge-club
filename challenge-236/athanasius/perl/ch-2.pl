#!perl

################################################################################
=comment

Perl Weekly Challenge 236
=========================

TASK #2
-------
*Array Loops*

Submitted by: Mark Anderson

You are given an array of unique integers.

Write a script to determine how many loops are in the given array.

    To determine a loop: Start at an index and take the number at array[index]
    and then proceed to that index and continue this until you end up at the
    starting index.

Example 1

  Input: @ints = (4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10)
  Output: 3

  To determine the 1st loop, start at index 0, the number at that index is 4,
  proceed to index 4, the number at that index is 15, proceed to index 15 and so
  on until you're back at index 0.

  Loops are as below:
  [4 15 1 6 13 5 0]
  [3 8 7 18 9 16 12 17 2]
  [14 11 19 10]

Example 2

  Input: @ints = (0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19)
  Output: 6

  Loops are as below:
  [0]
  [1]
  [13 9 14 17 18 15 5 8 2]
  [7 11 4 6 10 16 3]
  [12]
  [19]

Example 3

  Input: @ints = (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)
  Output: 1

  Loop is as below:
  [9 4 5 7 19 17 15 1 8 12 18 6 13 2 3 11 10 14 16 0]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The contents of the input array are the valid indices for that array (in any
order). Therefore:
1. The minimum array value is 0.
2. For an array of n elements, the maximum array value is (n - 1).
3. Since the array values are unique, each valid index is included in the input
   array exactly once.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If VERBOSE is set to a true value (the default), the output is followed by
   details of the loops found.

=cut
#===============================================================================

use v5.32.1;
use warnings;
use Const::Fast;
use List::Util     qw( max min uniqint );
use Regexp::Common qw( number );
use Test::More;

const my $FALSE   => 0;
const my $TRUE    => 1;
const my $VERBOSE => $TRUE;
const my $USAGE   =>
"Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of all valid array indices in any order\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 236, Task #2: Array Loops (Perl)\n\n";
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
        my $ints = parse_command_line();

        printf "Input:  \@ints = (%s)\n",  join ',', @$ints;

        my $loops = find_loops( $ints );
        my $count = scalar @$loops;

        print "Output: $count\n";

        if ($VERBOSE)
        {
            printf "\nLoop%s as below:\n", $count == 1 ? ' is' : 's are';
            printf "[%s]\n",               join ' ', @$_ for @$loops;
        }
    }
}

#-------------------------------------------------------------------------------
sub find_loops
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @loops;
    my  @found = ($FALSE) x scalar @$ints;

    for my $i (0 .. $#$ints)
    {
        next if $found[ $i ];

        my $start = $ints->[ $i ];
        my @loop  = $start;
        my $last  = $start;
        my $next  = -1;

        $found[ $start ] = 1;

        while ($TRUE)
        {
            $next = $ints->[ $last ];

            last if $next == $start;

            push @loop, $next;

            $found[ $next ] = $TRUE;

            $last = $next;
        }

        push @loops, [ @loop ];
    }

    return \@loops;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
        for @ARGV;

    my $min = min @ARGV;
    my $max = max @ARGV;

    $min == 0              or error( qq[Minimum is "$min", should be 0]      );
    $max == $#ARGV         or error( qq[Maximum is "$max", should be $#ARGV] );

    scalar  @ARGV == scalar uniqint @ARGV
                           or error( qq[Duplicate found] );

    return \@ARGV;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $ints_str) = split / \| /x, $line;

        $line = <DATA>;

        my @exp_strs = split / \| /x, $line;

        for ($test_name, $ints_str, @exp_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints  = split / \s+ /x, $ints_str;
        my $loops = find_loops( \@ints );
        my @expected;

        for my $exp_str (@exp_strs)
        {
            push @expected, [ split / \s+ /x, $exp_str ];
        }

        is_deeply $loops, \@expected, $test_name;
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
Example 1|4  6  3  8 15  0 13 18  7 16 14 19 17  5 11  1 12  2  9 10
          4 15  1  6 13  5  0| 3  8  7 18  9 16 12 17  2|14 11 19 10
Example 2|0  1 13  7  6  8 10 11  2 14 16  4 12  9 17  5  3 18 15 19
          0| 1|13  9 14 17 18 15  5  8  2| 7 11  4  6 10 16  3|12|19
Example 3|9  8  3 11  5  7 13 19 12  4 14 10 18  2 16  1  0 15  6 17
          9  4  5  7 19 17 15  1  8 12 18  6 13  2  3 11 10 14 16  0
