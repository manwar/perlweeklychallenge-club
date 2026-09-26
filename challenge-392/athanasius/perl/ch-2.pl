#!perl

################################################################################
=comment

Perl Weekly Challenge 392
=========================

TASK #2
-------
*Words Length Product*

Submitted by: Mohammad Sajid Anwar

You are given an array of strings.

Write a script to return the maximum value of len($words[i]) * len($words[j])
where the two words do not share common letters. If no such two words exist,
return 0.

Example 1

  Input: @words = ("a", "ab", "abc", "d", "de", "def")
  Output: 9

  Two words are "abc" and "def".

Example 2

  Input: @words = ("a", "aa", "aaa", "aaaa")
  Output: 0

  Since no two words can be chosen without sharing letters, the result is 0.

Example 3

  Input: @words = ("meet", "app", "code", "sky", "bold")
  Output: 16

  Two words are "meet" and "bold".

Example 4

  Input: @words = ("a", "ab", "abc", "abcd", "efghi")
  Output: 20

  Two words are "abcd" and "efghi".

Example 5

  Input: @words = ("xyz", "w", "abcdefg", "hij")
  Output: 21

  Two words are "abcdefg" and "hij".

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
2. A list of strings is entered on the command-line.
3. If either "-v" or "--verbose" is entered as a command-line flag, the required
   output (viz., the maximum word length product) is supplemented with details
   of the two words whose lengths form that product. (If two or more pairs of
   words have the same maximum word length product, only the first pair found is
   shown.)

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Set::Tiny;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-v|--verbose] [<words> ...]
  perl $0

    [<words> ...]    A non-empty list of strings
    -v|--verbose     Display the words whose lengths form the max product?
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 392, Task #2: Words Length Product (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $verbose;

    GetOptions( verbose => \$verbose ) or error( 'Invalid command-line flag' );

    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        printf "Input:  \@words = (%s)\n", join ', ', map { qq["$_"] } @ARGV;

        my ($product, $word1, $word2) = find_product( \@ARGV );

        print "Output: $product\n";

        print qq[\nThe two words are "$word1" and "$word2"\n]
            if $verbose && $product > 0;
    }
}

#-------------------------------------------------------------------------------
sub find_product
#-------------------------------------------------------------------------------
{
    my ($words)  = @_;
    my  @ordered = sort { length $b <=> length $a || $a cmp $b } @$words;
    my  $product = 0;
    my  @words;

    L_OUTER:
    for my $i (0 .. $#ordered - 1)
    {
        my $len1 = length $ordered[$i];
        my $set1 = Set::Tiny->new( split //, $ordered[$i] );

        for my $j ($i + 1 .. $#ordered)
        {
            my $len2 = length $ordered[$j];

            next L_OUTER if $len1 * $len2 <= $product;

            my $set2 = Set::Tiny->new( split //, $ordered[$j] );

            if ($set1->intersection( $set2 )->is_null)   # No shared letters
            {
                $product = $len1 * $len2;
                @words   = sort @ordered[$i, $j];
            }
        }
    }

    return $product, @words;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $expected, @words) = split / \| /x, $line;

        for ($test_name, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($product, $word1, $word2) = find_product( \@words );

        is  $product, $expected, $test_name;
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
Example 1| 9|a|ab|abc|d|de|def
Example 2| 0|a|aa|aaa|aaaa
Example 3|16|meet|app|code|sky|bold
Example 4|20|a|ab|abc|abcd|efghi
Example 5|21|xyz|w|abcdefg|hij
Test     | 9|abcde|f|abf|egh|abde
