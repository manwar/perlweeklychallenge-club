#!perl

################################################################################
=comment

Perl Weekly Challenge 342
=========================

TASK #2
-------
*Max Score*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, containing 0 and 1 only.

Write a script to return the max score after splitting the string into two non-
empty substrings. The score after splitting a string is the number of zeros in
the left substring plus the number of ones in the right substring.

Example 1

  Input: $str = "0011"
  Output: 4

  1: left = "0", right = "011" => 1 + 2 => 3
  2: left = "00", right = "11" => 2 + 2 => 4
  3: left = "001", right = "1" => 2 + 1 => 3

Example 2

  Input: $str = "0000"
  Output: 3

  1: left = "0", right = "000" => 1 + 0 => 1
  2: left = "00", right = "00" => 2 + 0 => 2
  3: left = "000", right = "0" => 3 + 0 => 3

Example 3

  Input: $str = "1111"
  Output: 3

  1: left = "1", right = "111" => 0 + 3 => 3
  2: left = "11", right = "11" => 0 + 2 => 2
  3: left = "111", right = "1" => 0 + 1 => 1

Example 4

  Input: $str = "0101"
  Output: 3

  1: left = "0", right = "101" => 1 + 2 => 3
  2: left = "01", right = "01" => 1 + 1 => 2
  3: left = "010", right = "1" => 2 + 1 => 3

Example 5

  Input: $str = "011101"
  Output: 5

  1: left = "0", right = "11101" => 1 + 4 => 5
  2: left = "01", right = "1101" => 1 + 3 => 4
  3: left = "011", right = "101" => 1 + 2 => 3
  4: left = "0111", right = "01" => 1 + 1 => 2
  5: left = "01110", right = "1" => 2 + 1 => 3

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
2. A single string, at least 2 characters long, and comprising only the charac-
   ters "0" and "1", is entered on the command-line.
   
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

    <str>    A 2+ character string containing only "0" and "1"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 342, Task #2: Max Score (Perl)\n\n";
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
        my $str =  $ARGV[0];
           $str =~ / ^ [01]{2,} $ /x
                   or error( qq[The input string "$str" is invalid] );

        print qq[Input:  \$str = "$str"\n];

        my $max_score = find_max_score( $str );

        print qq[Output: $max_score\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_max_score
#-------------------------------------------------------------------------------
{
    my ($str)   = @_;
    my  $max    = 0;
    my  @digits = split //, $str;
    my  $score  = 0;
        $score += $_ for @digits;

    for my $i (0 .. $#digits - 1)
    {
        $score += $digits[$i] ? -1 : 1;
        $max    = $score if $score > $max;
    }

    return $max;
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

        my $max_score = find_max_score( $str );

        is $max_score, $expected, $test_name;
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
Example 1|0011  |4
Example 2|0000  |3
Example 3|1111  |3
Example 4|0101  |3
Example 5|011101|5
