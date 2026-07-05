#!perl

################################################################################
=comment

Perl Weekly Challenge 380
=========================

TASK #1
-------
*Sum of Frequencies*

Submitted by: Mohammad Sajid Anwar

You are given a string consisting of English letters.

Write a script to find the vowel and consonant with maximum frequency. Return
the sum of two frequencies.

Example 1

  Input: $str = "banana"
  Output: 5

  Vowel: "a" appears 3 times.
  Consonant: "n" appears 2 times, "b" appears 1 time.

  Max frequency of vowel: 3
  Max frequency of consonant: 2

Example 2

  Input: $str = "teestett"
  Output: 7

  Vowel: "e" appears 3 times.
  Consonant: "t" appears 4 times, "s" appears 1 time.

  Max frequency of vowel: 3
  Max frequency of consonant: 4

Example 3

  Input: $str = "aeiouuaa"
  Output: 3

  Vowel: "a" appears 3 times, "u" 2 times, "e", "i", "o" 1 time each.
  Consonant: None.

  Max frequency of vowel: 3
  Max frequency of consonant: 0

Example 4

  Input: $str = "rhythm"
  Output: 2

  Vowel: None
  Consonant: "h" appears 2 times, "r", "y", "t", "m" 1 time each.

  Max frequency of vowel: 0
  Max frequency of consonant: 2

Example 5

  Input: $str = "x"
  Output: 1

  Vowel: None
  Consonant: "x" appears 1 time.

  Max frequency of vowel: 0
  Max frequency of consonant: 1

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
2. A string consisting of English letters only is entered on the command-line.

Assumptions
-----------
1. Letter comparisons are case-insensitive.
2. "English letters" do not include diacritics. So, for example, the spelling of
   "naïve" must be changed to "naive" for it to be a valid input string.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util qw( max );
use Test::More;

const my $LETTERS => qr/ ^ [a-z]*  $ /ix;
const my $VOWEL   => qr/ ^ [aeiou] $ /ix;
const my $USAGE   => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string of English letters
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 380, Task #1: Sum of Frequencies (Perl)\n\n";
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

        $str =~ $LETTERS or error( qq["$str" is not a valid input string] );

        print qq[Input:  \$str = "$str"\n];

        my $sum = sum_max_freqs( $str );

        print "Output: $sum\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub sum_max_freqs
#-------------------------------------------------------------------------------
{
    my ($str) =  @_;
        $str  =~ $LETTERS or die qq["$str" is not a valid input string];

    my (%vowels, %consts);

    for my $char (split //, $str)
    {
        my $target = $char =~ $VOWEL ? \%vowels : \%consts;

         ++$target->{ lc $char };
    }

    my $max_vowel = keys %vowels ? max( values %vowels ) : 0;
    my $max_const = keys %consts ? max( values %consts ) : 0;

    return $max_vowel + $max_const;
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

        my $sum = sum_max_freqs( $str );

        is $sum, $expected, $test_name;
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
Example 1|banana  |5
Example 2|teestett|7
Example 3|aeiouuaa|3
Example 4|rhythm  |2
Example 5|x       |1
Empty    |        |0
