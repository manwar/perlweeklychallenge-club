#!perl

################################################################################
=comment

Perl Weekly Challenge 312
=========================

TASK #1
-------
*Minimum Time*

Submitted by: Mohammad Sajid Anwar

You are given a typewriter with lowercase english letters a to z arranged in a
circle.

< Diagram: Task 1 >

Typing a character takes 1 sec. You can move pointer one character clockwise or
anti-clockwise.

The pointer initially points at a.

Write a script to return minimum time it takes to print the given string.

Example 1

  Input: $str = "abc"
  Output: 5

  The pointer is at 'a' initially.
  1 sec - type the letter 'a'
  1 sec - move pointer clockwise to 'b'
  1 sec - type the letter 'b'
  1 sec - move pointer clockwise to 'c'
  1 sec - type the letter 'c'

Example 2

  Input: $str = "bza"
  Output: 7

  The pointer is at 'a' initially.
  1 sec - move pointer clockwise to 'b'
  1 sec - type the letter 'b'
  1 sec - move pointer anti-clockwise to 'a'
  1 sec - move pointer anti-clockwise to 'z'
  1 sec - type the letter 'z'
  1 sec - move pointer clockwise to 'a'
  1 sec - type the letter 'a'

Example 3

  Input: $str = "zjpc"
  Output: 34

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string of lowercase English letters (a-z) is entered on the command-line.

=cut
#===============================================================================

use v5.32;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my @ALPHABET    => 'a' .. 'z';
const my $CIRCLE      => scalar @ALPHABET;
const my $HALF_CIRCLE => int( $CIRCLE / 2 );
const my $USAGE       => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string of lowercase English letters
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 312, Task #1: Minimum Time (Perl)\n\n";
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
        my $str =  $ARGV[ 0 ];
           $str =~ / ^ [a-z]* $ /x
               or error( qq[The input string "$str" is invalid] );

        print qq[Input:  \$str = "$str"\n];

        my $min_time = find_min_time( $str );

        print "Output: $min_time\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_min_time
#-------------------------------------------------------------------------------
{
    my ($str)     =  @_;
        $str      =~ / ^ [a-z]* $ /x or die qq[The string "$str" is invalid];
    my  $min_time =  length $str;
    my  @chars    = ('a', split //, $str);

    for my $i (1 .. $#chars)
    {
        my $diff   = abs( ord( $chars[ $i ] ) - ord( $chars[ $i - 1 ] ) );

        $min_time += $diff > $HALF_CIRCLE ? $CIRCLE - $diff : $diff;
    }

    return $min_time;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $min_time = find_min_time( $str );

        is $min_time, $expected, $test_name;
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
Example 1   |abc | 5
Example 2   |bza | 7
Example 3   |zjpc|34
Empty string|    | 0
One letter  |q   |11
No moves    |aaaa| 4
