#!perl

################################################################################
=comment

Perl Weekly Challenge 393
=========================

TASK #1
-------
*Pythagoras Multiplied*

Submitted by: Ulrich Rieke

You are given a positive integer n.

Find the number of all positive integer triplets (a, b, c) so that a^2 + b^2 =
c^2 and a, b and c are integers <= n.

Example 1

  Input: $n = 20
  Output: 12

  (3,4,5),  (4,3,5),   (5,12,13),(6,8,10),
  (8,6,10), (8,15,17), (9,12,15),(12,5,13),
  (12,9,15),(12,16,20),(15,8,17),(16,12,20)

Example 2

  Input: $n = 7
  Output: 2

  (3,4,5),(4,3,5)

Example 3

  Input: $n = 1
  Output: 0

Example 4

  Input: $n = 15
  Output: 8

Example 5

  Input: $n = 30
  Output: 22

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
2. A positive integer is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( any );
use Regexp::Common qw( number );
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
    print "\nChallenge 393, Task #1: Pythagoras Multiplied (Perl)\n\n";
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
        my $n = $ARGV[0];

        $n =~ / ^ $RE{num}{int} $ /x
                or error( qq["$n" is not a valid integer] );
        $n >= 0 or error( "$n is not positive" );

        print "Input:  \$n = $n\n";

        my $triplets = count_triplets( $n );

        print "Output: $triplets\n";
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_triplets
#-------------------------------------------------------------------------------
{
    my ($n)       = @_;
    my  $triplets = 0;

    if ($n >= 5)
    {
        my @squares = map { $_ * $_ } 1 .. $n;

        for my $i (0 .. $#squares - 2)
        {
            my $square_i = $squares[$i];

            for my $j ($i + 1 .. $#squares - 1)
            {
                my $sum = $square_i + $squares[$j];

                last if $sum > $squares[-1];

                $triplets += 2 if any { $_ == $sum } @squares;
            }
        }
    }

    return $triplets;
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

        my $triplets = count_triplets( $n );

        is $triplets, $expected, $test_name;
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
Example 1|20|12
Example 2| 7| 2
Example 3| 1| 0
Example 4|15| 8
Example 5|30|22
