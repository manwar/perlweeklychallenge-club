#!perl

################################################################################
=comment

Perl Weekly Challenge 238
=========================

TASK #2
-------
*Persistence Sort*

Submitted by: Mohammad S Anwar

You are given an array of positive integers.

Write a script to sort the given array in increasing order with respect to the
count of steps required to obtain a single-digit number by multiplying its
digits recursively for each array element. If any two numbers have the same
count of steps, then print the smaller number first.

Example 1

  Input: @int = (15, 99, 1, 34)
  Output: (1, 15, 34, 99)

  15 => 1 x 5 => 5 (1 step)
  99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
  1  => 0 step
  34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)

Example 2

  Input: @int = (50, 25, 33, 22)
  Output: (22, 33, 50, 25)

  50 => 5 x 0 => 0 (1 step)
  25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
  33 => 3 x 3 => 9 (1 step)
  22 => 2 x 2 => 4 (1 step)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
A "positive" integer is an unsigned integer (i.e., an integer >= 0).

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
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of positive integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 238, Task #2: Persistence Sort (Perl)\n\n";
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
        my $ints = \@ARGV;

        for (@$ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ >= 0                or error( "$_ is negative" );
        }

        my  $sorted = persistence_sort( $ints );
        my (@ints_str, @sort_str);

        for my $i (0 .. $#$ints)
        {
            my $width = length $ints  ->[ $i ];
            my $len_s = length $sorted->[ $i ];
               $width = $len_s if $len_s > $width; 

            push @ints_str, sprintf '%*s', $width, $ints  ->[ $i ];
            push @sort_str, sprintf '%*s', $width, $sorted->[ $i ];
        }

        printf "Input: \@int = (%s)\n", join ', ', @ints_str;
        printf "Output:       (%s)\n",  join ', ', @sort_str;
    }
}

#-------------------------------------------------------------------------------
sub persistence_sort
#-------------------------------------------------------------------------------
{
    my ($ints)  = @_;
    my  @sorted = sort { count_steps( $a ) <=> count_steps( $b )
                                     || $a <=> $b } @$ints;

    return \@sorted;
}

#-------------------------------------------------------------------------------
sub count_steps
#-------------------------------------------------------------------------------
{
    my ($num)    = @_;
    my  $steps   = 0;
    my  $product = $num;

    while (length $product > 1)
    {
        my @digits = split //, $product;
        $product   = $digits[ 0  ];
        $product  *= $digits[ $_ ] for 1 .. $#digits;
        ++$steps;
    }

    return $steps;
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

        my @ints     = split / \s+ /x, $int_str;
        my @expected = split / \s+ /x, $exp_str;
        my $sorted   = persistence_sort( \@ints );

        is_deeply $sorted, \@expected, $test_name;
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
Example 1|15 99  1 34| 1 15 34 99
Example 2|50 25 33 22|22 33 50 25
