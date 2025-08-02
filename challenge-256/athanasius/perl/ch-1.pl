#!perl

################################################################################
=comment

Perl Weekly Challenge 256
=========================

TASK #1
-------
*Maximum Pairs*

Submitted by: Mohammad Sajid Anwar

You are given an array of distinct words, @words.

Write a script to find the maximum pairs in the given array. The words $words[i]
and $words[j] can be a pair one is reverse of the other.

Example 1

  Input: @words = ("ab", "de", "ed", "bc")
  Output: 1

  There is one pair in the given array: "de" and "ed"

Example 2

  Input: @words = ("aa", "ba", "cd", "ed")
  Output: 0

Example 3

  Input: @words = ("uv", "qp", "st", "vu", "mn", "pq"))
  Output: 2

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If --case-sensitive is entered on the command-line (or simply omitted), "xy"
   and "XY" (for example) are treated as different words, so "xy" and "YX" do
   NOT form a pair; but if --nocase-sensitive is entered on the command-line,
   "xy" DOES pair with "YX".
3. If --palindromes is entered on the command-line, palindromes such as "a",
   "aba", and "CDEDC" pair with themselves; otherwise (i.e., if it is omitted or
   if --nopalindromes is entered on the command-line), they do not, as per
   Example 2.
4. If $VERBOSE is set to a true value, the required output (number of pairs
   found) is followed by a list of the pairs themselves.

=cut
#===============================================================================

use v5.32.1;             # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Test::More;

const my $CASE_SENSITIVE => 1;
const my $PALINDROMES    => 0;
const my $VERBOSE        => 1;
const my $USAGE          => <<END;
Usage:
  perl $0 [--[no]case-sensitive] [--[no]palindromes] [<words> ...]
  perl $0

    [<words> ...]    A non-empty array of distinct words
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 256, Task #1: Maximum Pairs (Perl)\n\n";
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
        my ($words, $case_sensitive, $palindromes) = parse_command_line();

        printf "Input:  \@words = (%s)\n", join ', ', map { qq["$_"] } @$words;

        my $pairs = count_pairs( $words, $case_sensitive, $palindromes );

        printf "Output: %d\n", scalar @$pairs;

        if ($VERBOSE)
        {
            printf "\nPair%s%s\n", scalar @$pairs == 1 ? ':   ' : 's:  ',
                join ', ', map { $_->[ 0 ] . '|' . $_->[ 1 ] } @$pairs;
        }
    }
}

#-------------------------------------------------------------------------------
sub count_pairs
#-------------------------------------------------------------------------------
{
    my ($words, $case_sensitive, $palindromes) = @_;
    my  @pairs;
    my  %seen = map { $_ => 0 } @$words;

    for my $lhs (sort @$words)
    {
        if (!$seen{ $lhs })
        {
            for my $rhs (sort @$words)
            {
                next if $seen{ $rhs } || (!$palindromes && $lhs eq $rhs);

                if (($case_sensitive &&    $lhs eq reverse    $rhs) ||
                   (!$case_sensitive && lc $lhs eq reverse lc $rhs))
                {
                    push @pairs, [ $lhs => $rhs ];

                    $seen{ $lhs } = 1;
                    $seen{ $rhs } = 1;
                }
            }
        }
    }

    return \@pairs;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $case_sensitive = $CASE_SENSITIVE;
    my $palindromes    = $PALINDROMES;

    GetOptions
    (
        'case_sensitive!' => \$case_sensitive,
        'palindromes!'    => \$palindromes,

    )   or error( 'Error in command line arguments' );

    my @words = @ARGV;

    scalar @words > 0
        or error( 'No input words found' );

    are_distinct( \@words, $case_sensitive )
        or error( 'The input words are not distinct' );

    return (\@words, $case_sensitive, $palindromes);
}

#-------------------------------------------------------------------------------
sub are_distinct
#-------------------------------------------------------------------------------
{
    my ($words, $case_sensitive) = @_;
    my  %dict;

    for (@$words)
    {
        my $word = $case_sensitive ? $_ : lc;

        return 0 if ++$dict{ $word } > 1;
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $words_str, $expected, $case_sensitive_str,
             $palindromes_str) = split / \| /x, $line;

        for ($test_name, $words_str, $expected, $case_sensitive_str,
             $palindromes_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $case_sensitive = $case_sensitive_str eq 'True';
        my $palindromes    = $palindromes_str    eq 'True';

        my @words = split / \s+ /x, $words_str;
        my $pairs = count_pairs( \@words, $case_sensitive, $palindromes );

        is scalar @$pairs, $expected, $test_name;
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
Example 1    |ab de ed bc      |1|     |
Example 2    |aa ba cd ed      |0|     |
Example 3    |uv qp st vu mn pq|2|     |
Palindromes 1|aba ab ba cd ef g|3|     |True
Palindromes 2|aba ab ba cd ef g|1|     |False
Case 1       |ab BA cD dC ef gh|2|False|
Case 2       |ab BA cD dC ef gh|0|True |
