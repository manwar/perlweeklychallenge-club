#!perl

################################################################################
=comment

Perl Weekly Challenge 321
=========================

TASK #2
-------
*Backspace Compare*

Submitted by: Mohammad Sajid Anwar

You are given two strings containing zero or more #.

Write a script to return true if the two given strings are same by treating # as
backspace.

Example 1

  Input: $str1 = "ab#c"
         $str2 = "ad#c"
  Output: true

  For first string,  we remove "b" as it is followed by "#".
  For second string, we remove "d" as it is followed by "#".
  In the end both strings became the same.

Example 2

  Input: $str1 = "ab##"
         $str2 = "a#b#"
  Output: true

Example 3

  Input: $str1 = "a#b"
         $str2 = "c"
  Output: false

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Backspace characters are processed from left to right within a string.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings, each containing zero or more "#" characters, are entered on the
   command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 321, Task #2: Backspace Compare (Perl)\n\n";
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
        my ($str1, $str2) = @ARGV;

        print qq[Input:  \$str1 = "$str1"\n];
        print qq[        \$str2 = "$str2"\n];

        my $strings_are_equal = compare_strings( $str1, $str2 );

        printf "Output: %s\n", $strings_are_equal ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub compare_strings
#-------------------------------------------------------------------------------
{
    my ($str1, $str2) = @_;
    my  $str1_nbs     = process_backspaces( $str1 );
    my  $str2_nbs     = process_backspaces( $str2 );

    return $str1_nbs eq $str2_nbs;
}

#-------------------------------------------------------------------------------
sub process_backspaces
#-------------------------------------------------------------------------------
{
    my ($str)   = @_;
    my  @source = split //, $str;
    my  @target;

    while (@source)
    {
        my $next = shift @source;

        if ($next eq '#')
        {
            pop  @target if @target;
        }
        else
        {
            push @target, $next;
        }
    }

    return join '', @target;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str1, $str2, $expected) = split / \| /x, $line;

        for ($test_name, $str1, $str2, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $strings_are_equal = compare_strings( $str1, $str2 );

        is $strings_are_equal, $expected eq 'true', $test_name;
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
Example 1|ab#c|ad#c|true
Example 2|ab##|a#b#|true
Example 3|a#b |c   |false
