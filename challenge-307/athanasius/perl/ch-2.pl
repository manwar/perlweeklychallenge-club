#!perl

################################################################################
=comment

Perl Weekly Challenge 307
=========================

TASK #2
-------
*Find Anagrams*

Submitted by: Mohammad Sajid Anwar

You are given a list of words, @words.

Write a script to find any two consecutive words and if they are anagrams, drop
the first word and keep the second. You continue this until there is no more
anagrams in the given list and return the count of final list.

Example 1

  Input: @words = ("acca", "dog", "god", "perl", "repl")
  Output: 3

  Step 1: "dog" and "god" are anagrams, so dropping "dog" and keeping "god"
      => ("acca", "god", "perl", "repl")
  Step 2: "perl" and "repl" are anagrams, so dropping "perl" and keeping "repl"
      => ("acca", "god", "repl")

Example 2

  Input: @words = ("abba", "baba", "aabb", "ab", "ab")
  Output: 2

  Step 1: "abba" and "baba" are anagrams, so dropping "abba" and keeping "baba"
      => ("baba", "aabb", "ab", "ab")
  Step 2: "baba" and "aabb" are anagrams, so dropping "baba" and keeping "aabb"
      => ("aabb", "ab", "ab")
  Step 3: "ab" and "ab" are anagrams, so dropping "ab" and keeping "ab"
      => ("aabb", "ab")

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
2. A non-empty list of words is entered on the command-line.
3. If the input list is preceded by the "-i" flag, case is ignored. For example,
   "Abc" and "CaB" are considered anagrams. Otherwise (the default), character-
   comparisons are case-sensitive.
4. If the input list is preceded by the "-v" flag, the contents of the final
   list are also shown.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use Getopt::Long;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-i] [-v] [<words> ...]
  perl $0

    -i               Ignore case? [default: False]
    -v               Show the final list? [default: False]
    [<words> ...]    A non-empty list of words
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 307, Task #2: Find Anagrams (Perl)\n\n";
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
        my ($ignore_case, $verbose, $words) = parse_command_line();

        printf "Case-\nsensitive?  %s\n",   $ignore_case ? 'No' : 'Yes';
        printf "Input:      \@words = (%s)\n",
                join ', ', map { qq["$_"] } @$words;

        my $final_list = find_final_list( $words, $ignore_case );

        printf "Output:     %d\n", scalar @$final_list;

        printf "\nFinal list: (%s)\n", join ', ', map { qq["$_"] } @$final_list
            if $verbose;
    }
}

#-------------------------------------------------------------------------------
sub find_final_list
#-------------------------------------------------------------------------------
{
    my ($words, $ignore_case) = @_;
    my  @new_list;

    for my $i (0 .. $#$words - 1)
    {
        push @new_list, $words->[ $i ]
            unless anagrams( $words->[ $i ], $words->[ $i + 1 ], $ignore_case );
    }

    push @new_list, $words->[ -1 ];

    return \@new_list;
}

#-------------------------------------------------------------------------------
sub anagrams
#-------------------------------------------------------------------------------
{
    my ($word1, $word2, $ignore_case) = @_;
    my  $w1 = join '', sort map { $ignore_case ? lc $_ : $_ } split //, $word1;
    my  $w2 = join '', sort map { $ignore_case ? lc $_ : $_ } split //, $word2;

    return $w1 eq $w2;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($ignore_case, $verbose);

    GetOptions
    (
        i => \$ignore_case,
        v => \$verbose
    )                       or error( 'Error in command-line arguments' );

    scalar @ARGV > 0        or error( 'The input list is empty' );

    return ($ignore_case, $verbose, \@ARGV);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $words_str, $expected) = split / \| /x, $line;

        for ($test_name, $words_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @words      = split / \s+ /x, $words_str;
        my $final_list = find_final_list( \@words, 0 );

        is scalar @$final_list, $expected, $test_name;
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
Example 1|acca dog god perl repl|3
Example 2|abba baba aabb ab ab  |2
