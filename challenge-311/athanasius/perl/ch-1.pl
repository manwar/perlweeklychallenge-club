#!perl

################################################################################
=comment

Perl Weekly Challenge 311
=========================

TASK #1
-------
*Upper Lower*

Submitted by: Mohammad Sajid Anwar

You are given a string consists of english letters only.

Write a script to convert lower case to upper and upper case to lower in the given string.

Example 1

  Input: $str = "pERl"
  Output: "PerL"

Example 2

  Input: $str = "rakU"
  Output: "RAKu"

Example 3

  Input: $str = "PyThOn"
  Output: "pYtHoN"

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
2. A single string containing only letters of the English alphabet is entered on
   the command-line.

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

    <str>    A string of letters from the English alphabet
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 311, Task #1: Upper Lower (Perl)\n\n";
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
           $str =~ / ^ [a-z]* $ /ix
               or error( qq[The input string "$str" is invalid] );

        print qq[Input: \$str = "$str"\n];

        my $converted = convert_upper_lower( $str );

        print qq[Output:       "$converted"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub convert_upper_lower
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    return $str =~ tr/A-Za-z/a-zA-Z/r;
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

        my $converted = convert_upper_lower( $str );

        is $converted, $expected, $test_name;
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
Example 1|pERl  |PerL
Example 2|rakU  |RAKu
Example 3|PyThOn|pYtHoN
