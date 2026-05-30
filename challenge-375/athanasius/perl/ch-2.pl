#!perl

################################################################################
=comment

Perl Weekly Challenge 375
=========================

TASK #2
-------
*Find K-Beauty*

Submitted by: Mohammad Sajid Anwar

You are given a number and a digit (k).

Write a script to find the K-Beauty of the given number. The K-Beauty of an
integer number is defined as the number of substrings of given number when it is
read as a string has length of 'k' and is a divisor of given number.

Example 1

  Input: $num = 240, $k = 2
  Output: 2

  Substring with length 2:
  24: 240 is divisible by 24
  40: 240 is divisible by 40

Example 2

  Input: $num = 1020, $k = 2
  Output: 3

  Substring with length 2:
  10: 1020 is divisible by 10
  02: 1020 is divisible by 2
  20: 1020 is divisible by 20

Example 3

  Input: $num = 444, $k = 2
  Output: 0

  Substring with length 2:
  First "44": 444 is not divisible by 44
  Second "44": 444 is not divisible by 44

Example 4

  Input: $num = 17, $k = 2
  Output: 1

  Substring with length 2:
  17: 17 is divisible by 17

Example 5

  Input: $num = 123, $k = 1
  Output: 2

  Substring with length 1:
  1: 123 is divisible by 1
  2: 123 is not divisible by 2
  3: 123 is divisible by 3

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
2. An integer is entered on the command-line, followed by a digit.

Assumptions
-----------
1. $k must be greater than 0.
2. $num is initially treated as an integer, not a string, so if $num is entered
   as, say, "002", it is first normalized to 2 and only then treated as a string
   from which substrings may be extracted.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Devel::Assert  qw( on );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <num> <k>
  perl $0

    <num>    An integer
    <k>      A non-zero digit
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 375, Task #2: Find K-Beauty (Perl)\n\n";
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
    elsif ($argc == 2)
    {
        my  ($num, $k) = @ARGV;

        for ($num, $k)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        1 <= $k <= 9               or error( "$k is not a valid digit" );

        remove_leading_zeros( $num );

        print "Input:  \$num = $num, \$k = $k\n";

        my $k_beauty = find_k_beauty( $num, $k );

        print "Output: $k_beauty\n";
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_k_beauty
#-------------------------------------------------------------------------------
{
    my ($num, $k) = @_;

    assert $num =~ / ^ $RE{num}{int} $ /x;
    assert $k   =~ / ^ $RE{num}{int} $ /x;
    assert 1 <= $k <= 9;

    remove_leading_zeros( $num );
    $num =~ s/ ^ [^0-9]+ //x;

    my $k_beauty = 0;

    if ($num == 0)
    {
        ++$k_beauty if $k == 1;
    }
    else
    {
        for my $i (0 .. length( $num ) - $k)
        {
            my $divisor = substr $num, $i, $k;

            ++$k_beauty if $num % $divisor == 0;
        }
    }

    return $k_beauty;
}

#-------------------------------------------------------------------------------
sub remove_leading_zeros
#-------------------------------------------------------------------------------
{
    $_[0] =~ s/ ^ ([+-]*) 0+ ([0-9]+) /$1$2/x;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $num, $k, $expected) = split / \| /x, $line;

        for ($test_name, $num, $k, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $k_beauty = find_k_beauty( $num, $k );

        is $k_beauty, $expected, $test_name;
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
Example 1    | 240|2|2
Example 2    |1020|2|3
Example 3    | 444|2|0
Example 4    |  17|2|1
Example 5    | 123|1|2
Leading zeros| 002|2|0
