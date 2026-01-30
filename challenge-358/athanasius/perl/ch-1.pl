#!perl

################################################################################
=comment

Perl Weekly Challenge 358
=========================

TASK #1
-------
*Max Str Value*

Submitted by: Mohammad Sajid Anwar

You are given an array of alphanumeric string, @strings.

Write a script to find the max value of alphanumeric string in the given array.
The numeric representation of the string, if it comprises of digits only other-
wise length of the string.

Example 1

  Input: @strings = ("123", "45", "6")
  Output: 123

  "123" -> 123
  "45"  -> 45
  "6"   -> 6

Example 2

  Input: @strings = ("abc", "de", "fghi")
  Output: 4

  "abc"  -> 3
  "de"   -> 2
  "fghi" -> 4

Example 3

  Input: @strings = ("0012", "99", "a1b2c")
  Output: 99

  "0012"  -> 12
  "99"    -> 99
  "a1b2c" -> 5

Example 4

  Input: @strings = ("x", "10", "xyz", "007")
  Output: 10

  "x"   -> 1
  "xyz" -> 3
  "007" -> 7
  "10"  -> 10

Example 5

  Input: @strings = ("hello123", "2026", "perl")
  Output: 2026

  "hello123" -> 8
  "perl"     -> 4
  "2026"     -> 2026

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
2. A non-empty list of alphanumeric strings is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<strings> ...]
  perl $0

    [<strings> ...]    A non-empty list of alphanumeric strings
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 358, Task #1: Max Str Value (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        for my $str (@ARGV)
        {
            $str =~ / ^ [A-Za-z0-9]* $ /x
                or error( qq["$str" is not an alphanumeric string] );
        }

        printf "Input:  \@strings = %s\n", join ', ', map { qq["$_"] } @ARGV;

        my $max = find_max_str_value( \@ARGV );

        print  "Output: $max\n";
    }
}

#-------------------------------------------------------------------------------
sub find_max_str_value
#-------------------------------------------------------------------------------
{
    my ($strings)  = @_;
    my  $max_value = 0;

    for my $string (@$strings)
    {
        my  $value = $string =~ / [^0-9] /x ? length $string : $string;
        $max_value = $value if $value > $max_value;
    }

    return $max_value;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $strings, $expected) = split / \| /x, $line;

        for ($test_name, $strings, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @strings = split / \s+ /x, $strings;
        my $max     = find_max_str_value( \@strings );

        is $max, $expected, $test_name;
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
Example 1|123 45 6          | 123
Example 2|abc de fghi       |   4
Example 3|0012 99 a1b2c     |  99
Example 4|x 10 xyz 007      |  10
Example 5|hello123 2026 perl|2026
