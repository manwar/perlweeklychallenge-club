#!perl

################################################################################
=comment

Perl Weekly Challenge 377
=========================

TASK #2
-------
*Prefix Suffix*

Submitted by: Mohammad Sajid Anwar

You are given an array of strings.

Write a script to find if the two strings (str1, str2) in the given array such
that str1 is prefix and suffix of str2. Return the total count of such pairs.

Example 1

  Input: @array = ("a", "aba", "ababa", "aa")
  Output: 4

  $array[0], $array[1]: "a" is a prefix and suffix of "aba"
  $array[0], $array[2]: "a" is a prefix and suffix of "ababa"
  $array[0], $array[3]: "a" is a prefix and suffix of "aa"
  $array[1], $array[2]: "aba" is a prefix and suffix of "ababa"

Example 2

  Input: @array = ("pa", "papa", "ma", "mama")
  Output: 2

  $array[0], $array[1]: "pa" is a prefix and suffix of "papa"
  $array[2], $array[3]: "ma" is a prefix and suffix of "mama"

Example 3

  Input: @array = ("abao", "ab")
  Output: 0

Example 4

  Input: @array = ("abab", "abab")
  Output: 1

  $array[0], $array[1]: "abab" is a prefix and suffix of "abab"

Example 5

  Input: @array = ("ab", "abab", "ababab")
  Output: 3

  $array[0], $array[1]: "ab" is a prefix and suffix of "abab"
  $array[0], $array[2]: "ab" is a prefix and suffix of "ababab"
  $array[1], $array[2]: "abab" is a prefix and suffix of "ababab"

Example 6

  Input: @array = ("abc", "def", "ghij")
  Output: 0

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
2. A non-empty list of strings is entered on the command-line.

Assumptions
-----------
1. It is clear that str1 and str2 must be different elements of the input list;
   that is, they must have different indices within the array.
2. But from Example 4 it appears that when str1 is identical to str2, the pair
   (str1, str2) does form a prefix/suffix pair. Now, Example 4 gives an expected
   count of 1, with the explanation: "abab" is a prefix and suffix of "abab".
   But in that case, both (str1, str2) and (str2, str1) are prefix/suffix pairs,
   and the count should be 2. The expected output in Example 4 has been adjusted
   accordingly in the test suite.
3. Comparisons are case-sensitive.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<array> ...]
  perl $0

    [<array> ...]    A non-empty list of strings
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 377, Task #2: Prefix Suffix (Perl)\n\n";
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
        printf qq[Input:  \@array = (%s)\n], join ', ', map { qq["$_"] } @ARGV;

        my $pairs = count_pairs( \@ARGV );

        print "Output: $pairs\n";
    }
}

#-------------------------------------------------------------------------------
sub count_pairs
#-------------------------------------------------------------------------------
{
    my ($array) = @_;
    my  $count  = 0;

    for my $i (0 .. $#$array)
    {
        my $str_i = $array->[$i];

        for my $j (0 .. $#$array)
        {
            next if $i == $j;

            ++$count if $array->[$j] =~ / ^ $str_i   /x &&
                        $array->[$j] =~ /   $str_i $ /x;
        }
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $strs, $expected) = split / \| /x, $line;

        for ($test_name, $strs, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @array = split / \s+ /x, $strs;
        my $pairs = count_pairs( \@array );

        is $pairs, $expected, $test_name;
    }

    done_testing;
}

################################################################################

__DATA__
Example 1|a aba ababa aa |4
Example 2|pa papa ma mama|2
Example 3|abao ab        |0
Example 4|abab abab      |2| Changed from 1. See Assumption 2 above
Example 5|ab abab ababab |3
Example 6|abc def ghij   |0
