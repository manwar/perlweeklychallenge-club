#!perl

################################################################################
=comment

Perl Weekly Challenge 330
=========================

TASK #1
-------
*Clear Digits*

Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and digits.

Write a script to remove all digits by removing the first digit and the closest
non-digit character to its left.

Example 1

  Input: $str = "cab12"
  Output: "c"

  Round 1: remove "1" then "b" => "ca2"
  Round 2: remove "2" then "a" => "c"

Example 2

  Input: $str = "xy99"
  Output: ""

  Round 1: remove "9" then "y" => "x9"
  Round 2: remove "9" then "x" => ""

Example 3

  Input: $str = "pa1erl"
  Output: "perl"

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
2. A string containing only lower case English letters and digits is entered on
   the command-line.

Assumptions
-----------
At each step of the process:
1. it is the left-most digit that is removed; and
2. if there are no non-digit characters to its left, only the digit is removed.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string containing only lower-case English letters and digits
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 330, Task #1: Clear Digits (Perl)\n\n";
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
        my $str = $ARGV[ 0 ];

        $str =~ / ([^a-z0-9]) /x and error( qq[Invalid character "$1"] );

        print qq[Input: \$str = "$str"\n];

        my $cleared = clear_digits( $str );

        print qq[Output:       "$cleared"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub clear_digits
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
        $str  =~ / ([^a-z0-9]) /x and die qq[Invalid character "$1"];

    1 while $str =~ s/ (?: ^ | \D ) \d //x;

    return $str;
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

        my $cleared = clear_digits( $str );

        is $cleared, $expected, $test_name;
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
Example 1|cab12 |c
Example 2|xy99  |
Example 3|pa1erl|perl
