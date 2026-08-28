#!perl

################################################################################
=comment

Perl Weekly Challenge 388
=========================

TASK #2
-------
*Secret Santa*

Submitted by: Roger Bell_West

A company with $n employees is running a Secret Santa exchange. Each employee
buys one gift and receives one gift.

Write a script to return the total number of valid gift assignments where no
employee receives the gift they originally bought (i.e., employee $i must not be
assigned gift $i).

Example 1

  Input: $n = 1
  Output: 0

  Only 1 participant exists. They would have to receive their own gift, which is
  invalid.

Example 2

  Input: $n = 2
  Output: 1

  Participants 1 and 2 must swap gifts ([2, 1]).

Example 3

  Input: $n = 3
  Output: 2

  The 2 valid gift arrays where array[i] is who person i+1 receives from:
  [2, 3, 1]
  [3, 1, 2]

Example 4

  Input: $n = 4
  Output: 9

  The 9 valid arrays are:
  [2, 1, 4, 3], [2, 3, 4, 1], [2, 4, 1, 3],
  [3, 1, 4, 2], [3, 4, 1, 2], [3, 4, 2, 1],
  [4, 1, 2, 3], [4, 3, 1, 2], [4, 3, 2, 1],

Example 5

  Input: $n = 5
  Output: 44

  There are 44 valid permutations out of 5! = 120 total possible arrangements.

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
2. The number of employees is entered on the command-line.

Note
----
"[A] permutation of the elements of a set in which no element appears in its
original position" is a derangement or subfactorial [2]. Beginning with n = 0,
the number of derangements of a set of size n are as follows:

  1, 0, 1, 2, 9, 44, 265, 1854, 14833, 133496, 1334961, ... [1], [2]

References
----------
[1] "A000166 Subfactorial or rencontres numbers, or derangements...", _OEIS_,
    https://oeis.org/A000166
[2] "Derangement", _Wikipedia_, https://en.wikipedia.org/wiki/Derangement

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use ntheory        qw( subfactorial );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <n>
  perl $0

    <n>    Number of employees
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 388, Task #2: Secret Santa (Perl)\n\n";
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
           $n >= 0 or error( '$n is negative' );

        print "Input:  \$n = $n\n";

        my $assignments = count_assignments( $n );

        printf "Output: %s\n", commify( $assignments );
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_assignments
#-------------------------------------------------------------------------------
{
    return subfactorial( $_[0] );
}

#-------------------------------------------------------------------------------
sub commify
#
# From _Perl Cookbook_, "2.17. Putting Commas in Numbers"
#-------------------------------------------------------------------------------
{
    my ($num) = @_;
    my  $text = reverse $num;

    $text =~ s/ (\d{3}) (?=\d) (?!\d*\.) /$1,/gx;

    return scalar reverse $text;
}
#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $n, $expected) = split / \| /x, $line;

        for ($test_name, $n, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $assignments = count_assignments( $n );

        $expected =~ s/ \_ //gx;

        is $assignments, $expected, $test_name;
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
Example 1| 1|                            0
Example 2| 2|                            1
Example 3| 3|                            2
Example 4| 4|                            9
Example 5| 5|                           44
Zero     | 0|                            1
Larger n |23|9_510_425_471_055_777_937_262
