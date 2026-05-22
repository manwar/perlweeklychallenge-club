#!perl

################################################################################
=comment

Perl Weekly Challenge 374
=========================

TASK #1
-------
*Count Vowel*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return all possible vowel substrings in the given string. A
vowel substring is a substring that only consists of vowels and has all five
vowels present in it.

Example 1

  Input: $str = "aeiou"
  Output: ("aeiou")

Example 2

  Input: $str = "aaeeeiioouu"
  Output: ("aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu")

  NOTE: Updated output [2025-05-18]

Example 3

  Input: $str = "aeiouuaxaeiou"
  Output: ("aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua")

  NOTE: Updated output [2025-05-18]

Example 4

  Input: $str = "uaeiou"
  Output: ("aeiou", "uaeio", "uaeiou")

Example 5

  Input: $str = "aeioaeioa"
  Output: ()

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

Assumptions
-----------
1. Vowels are NOT case-sensitive.
2. The vowel substrings returned constitute a multiset, in which the order of
   the substrings does not matter.

Note on Testing
---------------
The algorithm employed returns vowel substrings ordered (1) by their location
in the string (left-most first), and then (2) by length (shortest first). This
produces a different ordering from that given in the Examples.

To accommodate this - and given Assumption 2 - test comparisons are performed by
Test::Deep::cmp_deeply(), with the expected answers treated as a bag (i.e., a
multiset).

=cut
#===============================================================================

use v5.38.2;        # Enables strictures
use warnings;
use boolean;
use Const::Fast;
use List::MoreUtils qw( any );
use Test::Deep      qw( bag cmp_deeply );
use Test::More;

const my @VOWELS => qw( a e i o u );
const my $USAGE  => <<END;
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
    print "\nChallenge 374, Task #1: Count Vowel (Perl)\n\n";
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
        my $str = $ARGV[0];

        print qq[Input:  \$str = "$str"\n];

        my $vowel_substrings = find_vowel_substrings( $str );

        printf "Output: (%s)\n", join ', ', map { qq["$_"] } @$vowel_substrings;
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_vowel_substrings
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  @chrs = split //, $str;
    my  @vowel_substrs;

    for my $start (0 .. scalar( @chrs ) - scalar( @VOWELS ))
    {
        my $start_chr  = $chrs[$start];
        my $all_vowels = false;

        if (any { $_ eq $start_chr } @VOWELS)
        {
            my $substr = $start_chr;

            for my $current ($start + 1 .. $#chrs)
            {
                my $chr = $chrs[$current];

                last unless any { $_ eq $chr } @VOWELS;

                $substr .= $chr;

                if ($all_vowels || has_all_the_vowels( $substr ))
                {
                    push @vowel_substrs, $substr;
                    $all_vowels = true;
                }
            }
        }
    }

    return \@vowel_substrs;
}

#-------------------------------------------------------------------------------
sub has_all_the_vowels
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    for my $vowel (@VOWELS)
    {
        return false unless $str =~ / $vowel /ix;
    }

    return true;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, @expected) = split / \| /x, $line;

        for ($test_name, $str, @expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $vowel_substrings = find_vowel_substrings( $str );

        cmp_deeply $vowel_substrings, bag( @expected ), $test_name;
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
Example 1|aeiou        |aeiou
Example 2|aaeeeiioouu  |aaeeeiioou|aaeeeiioouu|aeeeiioou|aeeeiioouu
Example 3|aeiouuaxaeiou|aeiou|aeiou|eiouua|aeiouu|aeiouua
Example 4|uaeiou       |aeiou|uaeio|uaeiou
Example 5|aeioaeioa    |
