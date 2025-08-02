#!perl

################################################################################
=comment

Perl Weekly Challenge 272
=========================

TASK #2
-------
*String Score*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to return the score of the given string.

    The score of a string is defined as the sum of the absolute difference
    between the ASCII values of adjacent characters.

Example 1

  Input: $str = "hello"
  Output: 13

  ASCII values of characters:
  h = 104
  e = 101
  l = 108
  l = 108
  o = 111

  Score => |104 - 101| + |101 - 108| + |108 - 108| + |108 - 111|
        => 3 + 7 + 0 + 3
        => 13

Example 2

  Input: "perl"
  Output: 30

  ASCII values of characters:
  p = 112
  e = 101
  r = 114
  l = 108

  Score => |112 - 101| + |101 - 114| + |114 - 108|
        => 11 + 13 + 6
        => 30

Example 3

  Input: "raku"
  Output: 37

  ASCII values of characters:
  r = 114
  a = 97
  k = 107
  u = 117

  Score => |114 - 97| + |97 - 107| + |107 - 117|
        => 17 + 10 + 10
        => 37

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The input string may contain only printable ASCII characters, in the range ' '
(space, value 0x20 = 32) to '~' (tilde, value 0x7E = 176).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input string is entered on the command-line.

Note
----
Command-line input is assumed to be ASCII-encoded. The input is checked for non-
ASCII characters; however, if the input is in a different encoding, this might
not be detected. For example, when "perl ch-2.pl ΓΔ" is entered at a DOS prompt
under Windows 11, the script receives the input string as "G?", which passes the
ASCII check.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

use constant DEBUG  => 0;

const my $ASCII_MAX => '~';
const my $ASCII_MIN => ' ';
const my $USAGE     => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string of printable ASCII characters
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 272, Task #2: String Score (Perl)\n\n";
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

        validate_ascii( $str );

        print qq[Input:  \$str = "$str"\n];

        my $score = find_string_score( $str );

        print "Output: $score\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_string_score
#-------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  @ascii = map { ord() } split //, $str;
    my  $score = 0;

    for my $i (0 .. $#ascii - 1)
    {
        $score += abs( $ascii[ $i ] - $ascii[ $i + 1 ] );
    }

    return $score;
}

#-------------------------------------------------------------------------------
sub validate_ascii
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    if (DEBUG)
    {
        my @ords = map { ord() } split //, $str;

        printf qq[DEBUG:  \$str = "%s" (%s)\n],
               $str, join ' ', map { sprintf '%x', $_ } @ords;
    }

    for (split //, $str)
    {
        $ASCII_MIN le $_ le $ASCII_MAX
            or error( 'chr(' . ord . ') is not a printable ASCII character');
    }
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

        validate_ascii( $str ) if DEBUG;

        my $score = find_string_score( $str );

        is $score, $expected, $test_name;
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
Example 1|hello|13
Example 2|perl |30
Example 3|raku |37
