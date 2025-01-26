#!perl

################################################################################
=comment

Perl Weekly Challenge 305
=========================

TASK #2
-------
*Alien Dictionary*

Submitted by: Mohammad Sajid Anwar

You are given a list of words and alien dictionary character order.

Write a script to sort lexicographically the given list of words based on the
alien dictionary characters.

Example 1

  Input: @words = ("perl", "python", "raku")
         @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
  Output: ("raku", "python", "perl")

Example 2

  Input: @words = ("the", "weekly", "challenge")
         @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
  Output: ("challenge", "the", "weekly")

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. The alien dictionary comprises a subset of the printable ASCII character set,
   and may include upper- and lower-case letters, digits, and punctuation, but
   not the space or tab characters.
2. Sorting is case-sensitive. For example, if "A" and "a" both appear in the
   list of words to be sorted, they must have separate entries in the alien
   dictionary.
3. Duplicate characters in the alien dictionary are ignored; only the first such
   character is used in establishing the lexicographical order.
4. The words to be sorted must be composed entirely of characters in the alien
   dictionary.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string comprising the alien dictionary is entered on the command-line,
   followed by a non-empty list of words to be sorted. Whitespace within the
   alien dictionary string is optional, and will be ignored.

=cut
#===============================================================================

use v5.32;       # Enables strictures and warnings
use Const::Fast;
use List::Util   qw( max );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <alien> [<words> ...]
  perl $0

    <alien>          A string comprising an alien dictionary
    [<words> ...]    A non-empty list of words to be sorted
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 305, Task #2: Alien Dictionary (Perl)\n\n";
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
        error( "Expected 0 or 2+ command-line arguments, found 1" )
    }
    else
    {
        my ($alien, @words) = @ARGV;

        my @alien = grep { / ^ \S $ /x } split '', $alien;

        printf "Input: \@words = (%s)\n",   join ', ', map { qq["$_"] } @words;
        printf "       \@alien = qw/%s/\n", join ' ',  @alien;

        my $sorted = alien_sort( \@alien, \@words );

        printf "Output: (%s)\n", join ', ', map { qq["$_"] } @$sorted;
    }
}

#-------------------------------------------------------------------------------
sub alien_sort
#-------------------------------------------------------------------------------
{
    my ($alien, $words) = @_;
    my  $index = 1;
    my  %char_dict;

    exists $char_dict{ $_ } or $char_dict{ $_ } = $index++ for @$alien;

    my $alt     = join '|', @$alien;
    my $max_len = max( map { length } @$words );
    my %word_dict;

    for my $word (@$words)
    {
        $word =~ / ^ (?: $alt )+ $ /x or
            error( qq[Invalid character found in word "$word"] );

        my $score  = '';
           $score .= sprintf '%03s', $char_dict{ $_ } for split //, $word;
           $score .= '000' for 1 .. $max_len - length $word;

        $word_dict{ $word } = $score;
    }

    return [ sort { $word_dict{ $a } <=> $word_dict{ $b } } @$words ];
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $words_str, $alien_str, $exptd_str) =
             split / \| /x, $line;

        for ($test_name, $words_str, $alien_str, $exptd_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @alien    = grep { / ^ \S $ /x } split //, $alien_str;
        my @words    = split / \s+ /x, $words_str;
        my @expected = split / \s+ /x, $exptd_str;
        my $sorted   = alien_sort( \@alien, \@words );

        is_deeply $sorted, \@expected, $test_name;
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
Example 1|perl python raku    |hlabydefgirkmnopqjstuvwxcz|raku python perl
Example 2|the weekly challenge|corldabtefghijkmnpqswuvxyz|challenge the weekly
Lengths  |butte but butter    |rtube                     |but butte butter
