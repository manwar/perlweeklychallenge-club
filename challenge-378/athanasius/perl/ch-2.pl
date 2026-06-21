#!perl

################################################################################
=comment

Perl Weekly Challenge 378
=========================

TASK #2
-------
*Sum of Words*

Submitted by: Mohammad Sajid Anwar

You are given three strings consisting of lower case English letters 'a' to 'j'
only. The letter value of a = 0, b = 1, c = 3, etc.

Write a script to find if sum of first two strings return the third string.

Example 1

  Input: $str1 = "acb", $str2 = "cba", $str3 = "cdb"
  Output: true

  $str1 = "acb" = 021
  $str2 = "cba" = 210
  $str3 = "cdb" = 231
  $str1 + $str2 = $str3

Example 2

  Input: $str1 = "aab", $str2 = "aac", $str3 = "ad"
  Output: true

  $str1 = "aab" = 001
  $str2 = "aac" = 002
  $str3 = "ad"  = 03

Example 3

  Input: $str1 = "bc", $str2 = "je", $str3 = "jg"
  Output: false

  $str1 = "bc" = 12
  $str2 = "je" = 94
  $str3 = "jg" = 96

Example 4

  Input: $str1 = "a", $str2 = "aaaa", $str3 = "aa"
  Output: true

  $str1 = "a"    = 0
  $str2 = "aaaa" = 0000
  $str3 = "aa"   = 00

Example 5

  Input: $str1 = "c", $str2 = "d", $str3 = "h"
  Output: false

  $str1 = "c" = 2
  $str2 = "d" = 3
  $str3 = "h" = 7

Example 6

  Input: $str1 = "gfi", $str2 = "hbf", $str3 = "bdhd"
  Output: true

  $str1 =  "gfi" =  658
  $str2 =  "hbf" =  715
  $str3 = "bdhd" = 1373

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
2. Three strings, each consisting of lower case English letters 'a' to 'j' only,
   are entered on the command-line.

Assumption
----------
The input strings are not empty.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str1> <str2> <str3>
  perl $0

    <str1>    1st string ('a' to 'j' only, non-empty)
    <str2>    2nd string ('a' to 'j' only, non-empty)
    <str3>    3rd string ('a' to 'j' only, non-empty)
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 378, Task #2: Sum of Words (Perl)\n\n";
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
    elsif ($argc == 3)
    {
        my ($str1, $str2, $str3) = @ARGV;

        for my $str ($str1, $str2, $str3)
        {
            is_word( $str ) or error( qq[Invalid word "$str"] );
        }

        printf qq[Input:  \$str1 = "%s", \$str2 = "%s", \$str3 = "%s"\n],
               $str1, $str2, $str3;

        my $sum = words_sum( $str1, $str2, $str3 );

        printf "Output: %s\n", $sum ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 3 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub words_sum
#-------------------------------------------------------------------------------
{
    my ($str1, $str2, $str3) = @_;
    my  @vals;

    for my $str ($str1, $str2, $str3)
    {
        is_word( $str ) or die qq[Invalid word "$str", stopped];

        push @vals, $str =~ tr/a-j/0-9/r;
    }

    return $vals[0] + $vals[1] == $vals[2];
}

#-------------------------------------------------------------------------------
sub is_word
#-------------------------------------------------------------------------------
{
    return $_[0] =~ / ^ [a-j]+ $ /x;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str1, $str2, $str3, $exp) = split / \| /x, $line;

        for ($test_name, $str1, $str2, $str3, $exp)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $sum = words_sum( $str1, $str2, $str3 ) ? 'true' : 'false';

        is $sum, $exp, $test_name;
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
Example 1|acb| cba| cdb|true
Example 2|aab| aac|  ad|true
Example 3| bc|  je|  jg|false
Example 4|  a|aaaa|  aa|true
Example 5|  c|   d|   h|false
Example 6|gfi| hbf|bdhd|true
