#!perl

################################################################################
=comment

Perl Weekly Challenge 398
=========================

TASK #2
-------
*String Difference*

Submitted by: Mohammad Sajid Anwar

You are given an array of equal length strings.

Write a script to find the difference integer array of each word in the given
array. There will be one word with a different array; return that word.

  Each words[i] can be converted into a difference integer array difference[i]
  of length n - 1 where difference[i][j] = words[i][j+1] - words[i][j]

Example 1

  Input: @words = ("ab", "bc", "cd", "zy")
  Output: "zy"

  "ab" => [1 - 0] = [1]
  "bc" => [2 - 1] = [1]
  "cd" => [3 - 2] = [1]
  "zy" => [24 - 25] = [-1]

Example 2

  Input: @words = ("cba", "fed", "azy")
  Output: "azy"

  "cba" => [1 - 2, 0 - 1] = [-1, -1]
  "fed" => [4 - 5, 3 - 4] = [-1, -1]
  "azy" => [25 - 0, 24 - 25] = [25, -1]

Example 3

  Input: @words = ("pop", "ada", "beb", "cfc")
  Output: "pop"

  "pop" => [14 - 15, 15 - 14] = [-1, 1]
  "ada" => [3 - 0, 0 - 3] = [3, -3]
  "beb" => [4 - 1, 1 - 4] = [3, -3]
  "cfc" => [5 - 2, 2 - 5] = [3, -3]

Example 4

  Input: @words = ("aaaa", "zzzz", "mmmm", "aaba")
  Output: "aaba"

  "aaaa" => [0 - 0, 0 - 0, 0 - 0] = [0, 0, 0]
  "zzzz" => [25 - 25, 25 - 25, 25 - 25] = [0, 0, 0]
  "mmmm" => [12 - 12, 12 - 12, 12 - 12] = [0, 0, 0]
  "aaba" => [0 - 0, 1 - 0, 0 - 1] = [0, 1, -1]

Example 5

  Input: @words = ("aceg", "bdfh", "cegi", "azbz")
  Output: "azbz"

  "aceg" => [2 - 0, 4 - 2, 6 - 4] = [2, 2, 2]
  "bdfh" => [3 - 1, 5 - 3, 7 - 5] = [2, 2, 2]
  "cegi" => [4 - 2, 6 - 4, 8 - 6] = [2, 2, 2]
  "azbz" => [25 - 0, 1 - 25, 25 - 1] = [25, -24, 24]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. The input list must contain at least 3 elements.
2. The Task Description specifies: "There will be one word with a different
   array; return that word." Hence, the input is invalid unless it produces a
   set of difference arrays in which exactly one array differs from all the
   others. However, as this cannot be ascertained until the difference arrays
   have been calculated, it seems better in such a case to return "<none>" as
   the result, rather than to issue an error message for invalid input data.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 3 or more same-length strings, where the length of each string is
   greater than 1, is entered on the command-line.
3. If "-v" or "--verbose" is entered as a command-line flag (along with 3 or
   more same-length strings), the standard output is followed by a table of the
   difference arrays for each of the input words.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use boolean;
use Const::Fast;
use Getopt::Long;
use List::Util     qw( max );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-v] [<words> ...]
  perl $0

    [<words> ...]    A list of 3 or more n-length strings, where n > 1
    -v               Show the difference array? [default: False]
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 398, Task #2: String Difference (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $verbose;

    GetOptions( verbose => \$verbose )
        or error( 'Invalid command-line argument(s)' );

    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc <  3)
    {
        error( "Expected 0 or 3+ arguments, found $argc" );
    }
    else
    {
        valid_strings( \@ARGV ) or error( 'Invalid input' );

        printf "Input:  \@words = (%s)\n", join ', ', map { qq["$_"] } @ARGV;

        my %word2diffs;

        my $diff_word = find_string_differences( \@ARGV, \%word2diffs );

        printf "Output: %s\n", $diff_word ? qq["$diff_word"] : '<none>';

        printf "\n%s\n", format_diff_array( \%word2diffs ) if $verbose;
    }
}

#-------------------------------------------------------------------------------
sub find_string_differences
#-------------------------------------------------------------------------------
{
    my ($words, $word2diffs) = @_;

    scalar @$words > 0 && valid_strings( $words ) or die '$words is invalid';

      %$word2diffs = %{ find_diffs( $words ) };
    my $diff2words = reverse_hash( $word2diffs );
    my $diff_word  = '';

    if (scalar %$diff2words == 2)
    {
        my ($key0, $key1) = sort keys %$diff2words;

        if    (scalar @{ $diff2words->{ $key0 } } == 1 &&
               scalar @{ $diff2words->{ $key1 } } >  1)
        {
            $diff_word = $diff2words->{ $key0 }->[0];
        }
        elsif (scalar @{ $diff2words->{ $key0 } } >  1 &&
               scalar @{ $diff2words->{ $key1 } } == 1)
        {
            $diff_word = $diff2words->{ $key1 }[0];
        }
    }

    return $diff_word;
}

#-------------------------------------------------------------------------------
sub find_diffs
#-------------------------------------------------------------------------------
{
    my ($words) = @_;

    scalar @$words > 0 && valid_strings( $words ) or die '$words is invalid';

    my %word2diffs;

    for my $word (@$words)
    {
        if (!exists $word2diffs{ $word })
        {
            my @word_diffs;
            my @chars = split //, $word;

            for my $i (1 .. $#chars)
            {
                push @word_diffs, ord( $chars[$i] ) - ord( $chars[$i - 1] );
            }

            push @{ $word2diffs{ $word } }, @word_diffs;
        }
    }

    return \%word2diffs;
}

#-------------------------------------------------------------------------------
sub reverse_hash
#-------------------------------------------------------------------------------
{
    my ($word2diffs) = @_;
    my  %diff2words;

    for my $word (keys %$word2diffs)
    {
        my @diffs = @{ $word2diffs->{ $word } };
        my $key   = join '|', @diffs;

        push @{ $diff2words{ $key } }, $word;
    }

    return \%diff2words;
}

#-------------------------------------------------------------------------------
sub valid_strings
#-------------------------------------------------------------------------------
{
    my ($words) = @_;

    return false if scalar @$words < 3;

    my $length = length $words->[0];

    for my $i (1 .. $#$words)
    {
        return false if length $words->[$i] != $length;
    }

    return true;
}

#-------------------------------------------------------------------------------
sub format_diff_array
#-------------------------------------------------------------------------------
{
    my ($word2diffs) = @_;
    my  $str         = '';
    my  $n_diffs     = scalar %$word2diffs;
    my  @widths      = (1) x $n_diffs;

    for my $word (keys %$word2diffs)
    {
        my @diffs = @{ $word2diffs->{ $word } };

        for my $i (0 .. $#diffs)
        {
            $widths[$i] = max( $widths[$i], length $diffs[$i] );
        }
    }

    for my $word (sort keys %$word2diffs)
    {
        $str .= qq{"$word" => [};

        my @diffs = @{ $word2diffs->{ $word } };
        my @diff_strs;

        for my $i (0 .. $#diffs)
        {
            push @diff_strs, sprintf '%*d', $widths[$i], $diffs[$i];
        }

        $str .= sprintf "%s]\n", join ', ', @diff_strs;
    }

    chomp  $str;

    return $str;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $words_str, $exp_result, @exp_diff_strs) =
             split / \| /x, $line;

        for ($test_name, $words_str, $exp_result, @exp_diff_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my %word2diffs;
        my @words     = split / \s+ /x, $words_str;
        my $diff_word = find_string_differences( \@words, \%word2diffs );
        my %exp_diffs;

        for my $i (0 .. $#words)
        {
            $exp_diffs{ $words[$i] } = [ split / \s+ /x, $exp_diff_strs[$i] ];
        }

        is         $diff_word,   $exp_result, "$test_name: result";
        is_deeply \%word2diffs, \%exp_diffs,  "$test_name: differences";
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
Example 1 |ab   bc   cd   zy  |zy  | 1      | 1      | 1      |-1
Example 2 |cba  fed  azy      |azy |-1 -1   |-1 -1   |25 -1
Example 2a|cba  fed  azy  xxx |    |-1 -1   |-1 -1   |25 -1   | 0   0
Example 3 |pop  ada  beb  cfc |pop |-1  1   | 3 -3   | 3 -3   | 3  -3
Example 4 |aaaa zzzz mmmm aaba|aaba| 0  0  0| 0  0  0| 0  0  0| 0   1 -1
Example 5 |aceg bdfh cegi azbz|azbz| 2  2  2| 2  2  2| 2  2  2|25 -24 24
