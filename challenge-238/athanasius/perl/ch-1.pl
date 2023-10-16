#!perl

################################################################################
=comment

Perl Weekly Challenge 238
=========================

TASK #1
-------
*Running Sum*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to return the running sum of the given array. The running sum can
be calculated as sum[i] = num[0] + num[1] + …. + num[i].

Example 1

  Input: @int = (1, 2, 3, 4, 5)
  Output: (1, 3, 6, 10, 15)

Example 2

  Input: @int = (1, 1, 1, 1, 1)
  Output: (1, 2, 3, 4, 5)

Example 3

  Input: @int = (0, -1, 1, 2)
  Output: (0, -1, 0, 2)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use v5.32.1;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<int> ...]
  perl $0

    [<int> ...]    A non-empty list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 238, Task #1: Running Sum (Perl)\n\n";
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
        my $int = \@ARGV;

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @$int;

        my $sum = find_running_sum( $int );

        my (@int_str, @sum_str);

        for my $i (0 .. $#$int)
        {
            my $width = length $int->[ $i ];
            my $len_s = length $sum->[ $i ];
               $width = $len_s if $len_s > $width; 

            push @int_str, sprintf '%*s', $width, $int->[ $i ];
            push @sum_str, sprintf '%*s', $width, $sum->[ $i ];
        }

        printf "Input: \@int = (%s)\n", join ', ', @int_str;
        printf "Output:       (%s)\n",  join ', ', @sum_str;
    }
}

#-------------------------------------------------------------------------------
sub find_running_sum
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @sum   = $ints->[ 0 ];

    for my $i (1 .. $#$ints)
    {
        push @sum, $ints->[ $i ] + $sum[ -1 ];
    }

    return \@sum;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $int_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @int = split / \s+ /x, $int_str;
        my @exp = split / \s+ /x, $exp_str;
        my $sum = find_running_sum( \@int );

        is_deeply $sum, \@exp, $test_name;
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
Example 1| 1  2 3  4 5| 1  3 6 10 15
Example 2| 1  1 1  1 1| 1  2 3  4  5
Example 3| 0 -1 1  2  | 0 -1 0  2
Negatives|-3 -2 6 -1 4|-3 -5 1  0  4
