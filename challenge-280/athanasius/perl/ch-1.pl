#!perl

################################################################################
=comment

Perl Weekly Challenge 280
=========================

TASK #1
-------
*Twice Appearance*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, containing lowercase English letters only.

Write a script to print the first letter that appears twice.

Example 1

  Input: $str = "acbddbca"
  Output: "d"

Example 2

  Input: $str = "abccd"
  Output: "c"

Example 3

  Input: $str = "abcdabbb"
  Output: "a"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
Otherwise:
2. The input string is entered on the command-line.

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

    <str>    A string of lower case letters
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 280, Task #1: Twice Appearance (Perl)\n\n";
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

        $str =~ / ^ [a-z]* $ /x or error( qq[Invalid input string "$str"] );

        print  qq[Input:  \$str = "$str"\n];

        my $frl = find_first_repeated_letter( $str );

        printf "Output: %s\n", $frl eq '' ? '<none>' : qq["$frl"];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_first_repeated_letter
#-------------------------------------------------------------------------------
{
    my ($str) =  @_;
        $str  =~ / ^ [a-z]* $ /x or die 'Invalid string';
    my  $frl  = '';
    my  %dict;

    for my $letter (split //, $str)
    {
        if (++$dict{ $letter } > 1)
        {
            $frl = $letter;
            last;
        }
    }

    return $frl;
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

        my $frl = find_first_repeated_letter( $str );

        is $frl, $expected, $test_name;
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
Example 1 |acbddbca        |d
Example 2 |abccd           |c
Example 3 |abcdabbb        |a
Empty     |                |
Singletons|abcdefghijklmnop|
