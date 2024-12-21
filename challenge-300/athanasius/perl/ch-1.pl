#!perl

################################################################################
=comment

Perl Weekly Challenge 300
=========================

TASK #1
-------
*Beautiful Arrangement*

Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.

Write a script to return the number of beautiful arrangements that you can con-
struct.

  A permutation of n integers, 1-indexed, is considered a beautiful arrangement
  if for every i (1 <= i <= n) either of the following is true:

  1) perm[i] is divisible by i
  2) i is divisible by perm[i]

Example 1

  Input: $n = 2
  Output: 2

  1st arrangement: [1, 2]
      perm[1] is divisible by i = 1
      perm[2] is divisible by i = 2
  2nd arrangement: [2, 1]
      perm[1] is divisible by i = 1
      i=2 is divisible by perm[2] = 1

Example 2

  Input: $n = 1
  Output: 1

Example 3

  Input: $n = 10
  Output: 700

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
2. A positive integer is entered on the command-line.

Reference
---------
"A320843: Number of permutations sigma of {1,2,...,n} such that sigma(i) divides
i or i divides sigma(i) for 1 <= i <= n.", The Online Encyclopedia of Integer
Sequences, https://oeis.org/A320843

=cut
#===============================================================================

use v5.32;            # Enables strictures
use warnings;
use Const::Fast;
use Math::Prime::Util qw( forperm );
use Regexp::Common    qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <n>
  perl $0

    <n>    A positive integer
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 300, Task #1: Beautiful Arrangement (Perl)\n\n";
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
    elsif ($argc == 1)
    {
        my $n = $ARGV[ 0 ];
           $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );
           $n > 0 or error( "$n is not positive" );

        print "Input:  \$n = $n\n";

        my $beautiful = count_beautiful_arrangements( $n );

        print "Output: $beautiful\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_beautiful_arrangements
#-------------------------------------------------------------------------------
{
    my ($n)    =  @_;
    my  $count =  0;
    my  @range = (1 .. $n);

    forperm
    {
        my $fail = 0;
        my @perm = map { $_ + 1 } @_;

        # Start at $i = 1, because $i = 0 => $j = 1, and (X % 1 == 0) is always
        # true

        for my $i (1 .. $#perm)
        {
            my $j = $i + 1;

            if ($perm[ $i ] % $j != 0 && $j % $perm[ $i ] != 0)
            {
                $fail = 1;
                last;
            }
        }

        ++$count unless $fail;

    } @range;

    return $count;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $n, $expected) = split / \| /x, $line;

        for ($test_name, $n, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $beautiful = count_beautiful_arrangements( $n );

        is $beautiful, $expected, $test_name;
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
Example 1| 2|  2
Example 2| 1|  1
Example 3|10|700
