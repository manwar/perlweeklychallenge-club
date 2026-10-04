#!perl

################################################################################
=comment

Perl Weekly Challenge 393
=========================

TASK #2
-------
*Prime Step*

Submitted by: Ulrich Rieke

You are given a string with English alphabetic characters only.

What is the absolute difference of the sum of the ASCII values of the characters
in the string to the nearest prime number?

Example 1

  Input: $str = "hello"
  Output: 9

  The ordinal values of "hello" are [104,101,108,108,111], summing up to 532.
  The nearest prime number to 532 is 523, resulting in an absolute difference of
  9.

Example 2

  Input: $str = "football"
  Output: 2

  Starting with the values [102,111,111,116,98,97,108,108] and the sum 841.
  We find 839 as the nearest prime number, so the difference is 2.

Example 3

  Input: $str = "a"
  Output: 0

Example 4

  Input: $str = "challenge"
  Output: 2

  The ordinal values of "challenge" are [99, 104, 97, 108, 108, 101, 110, 103,
  101], which sum up to 931.
  The nearest prime number to 931 is 929, so the difference is 2.

Example 5

  Input: $str = "perl"
  Output: 2

  The ordinal values of "perl" are [112, 101, 114, 108], summing up to 435.
  Nearest prime is 433, so the difference is 2.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
"English alphabetic characters" are the letters 'A' to 'Z' and 'a' to 'z' only.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string of one or more English letters is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;          # Enables strictures
use warnings;
use Const::Fast;
use Math::Prime::Util qw( is_prime next_prime prev_prime );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string of one or more letters from the English alphabet
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 393, Task #2: Prime Step (Perl)\n\n";
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
        my $str = $ARGV[0];

        $str =~ / ^ [A-Za-z]+ $ /x
            or error( qq["$str" is not a valid input string] );

        print qq[Input:  \$str = "$str"\n];

        my $prime_step = find_prime_step( $str );

        print "Output: $prime_step\n";
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_prime_step
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  $step = 0;
    my  $sum  = 0;
        $sum += ord for split //, $str;

    unless (is_prime( $sum ))
    {
        my $next_step = next_prime( $sum ) - $sum;
        my $prev_step = $sum - prev_prime( $sum );

        $step = ($next_step <= $prev_step) ? $next_step : $prev_step;
    }

    return $step;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $prime_step = find_prime_step( $str );

        is $prime_step, $expected, $test_name;
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
Example 1|hello    |9
Example 2|football |2
Example 3|a        |0
Example 4|challenge|2
Example 5|perl     |2
