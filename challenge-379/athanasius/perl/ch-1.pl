#!perl

################################################################################
=comment

Perl Weekly Challenge 379
=========================

TASK #1
-------
*Reverse String*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to reverse the given string without using standard reverse
function.

Example 1

  Input: $str = ""
  Output: ""

Example 2

  Input: $str = "reverse the given string"
  Output: "gnirts nevig eht esrever"

Example 3

  Input: $str = "Perl is Awesome"
  Output: "emosewA si lreP"

Example 4

  Input: $str = "v1.0.0-Beta!"
  Output: "!ateB-0.0.1v"

Example 5

  Input: $str = "racecar"
  Output: "racecar"

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
2. A single string is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 379, Task #1: Reverse String (Perl)\n\n";
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
        my ($str) = @ARGV;

        print qq[Input: \$str = "$str"\n];

        my $reversed = reverse_string( $str );

        print qq[Output:       "$reversed"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub reverse_string
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  $rev  = '';

    $rev .= chop $str while $str;

    return $rev;
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

        my $reversed = reverse_string( $str );

        is $reversed, $expected, $test_name;
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
Example 1||
Example 2|reverse the given string|gnirts nevig eht esrever
Example 3|Perl is Awesome|emosewA si lreP
Example 4|v1.0.0-Beta!|!ateB-0.0.1v
Example 5|racecar|racecar
