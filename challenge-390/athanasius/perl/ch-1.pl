#!perl

################################################################################
=comment

Perl Weekly Challenge 390
=========================

TASK #1
-------
*Decode String*

Submitted by: Mohammad Sajid Anwar

You are given an encoded string.

Write a script to return the decoded string of the given encoded string.

  The encoding rule is: K[encoded_string], where the encoded_string inside the
  square brackets is repeated exactly K > 0 times.

Example 1

  Input: $str = "2[3[a]]"
  Output: "aaaaaa"

  3[a]    => aaa
  2[3[a]] => aaa aaa

Example 2

  Input: $str = "10[a]"
  Output: "aaaaaaaaaa"

Example 3

  Input: $str = "a2[b]c3[d]e"
  Output: "abbcddde"

Example 4

  Input: $str = "2[a2[b]c]"
  Output: "abbcabbc"

Example 5

  Input: $str = "1[a]2[b3[c]]"
  Output: "abcccbccc"

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
2. A single encoded string is entered on the command-line.

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

    <str>    An encoded string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 390, Task #1: Decode String (Perl)\n\n";
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

        print qq[Input:  \$str = "$str"\n];

        my $decoded = decode_string( $str );

        print qq[Output: "$decoded"\n];
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub decode_string
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    1 while $str =~ s/ (\d+) \[ ([^\[\]]+) \] / $2 x $1 /egx;

    return  $str;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $encoded_str, $expected) = split / \| /x, $line;

        for ($test_name, $encoded_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $decoded = decode_string( $encoded_str );

        is $decoded, $expected, $test_name;
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
Example 1|2[3[a]]     |aaaaaa
Example 2|10[a]       |aaaaaaaaaa
Example 3|a2[b]c3[d]e |abbcddde
Example 4|2[a2[b]c]   |abbcabbc
Example 5|1[a]2[b3[c]]|abcccbccc
