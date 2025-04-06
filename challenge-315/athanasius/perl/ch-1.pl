#!perl

################################################################################
=comment

Perl Weekly Challenge 315
=========================

TASK #1
-------
*Find Words*

Submitted by: Mohammad Sajid Anwar

You are given a list of words and a character.

Write a script to return the index of word in the list where you find the given
character.

Example 1

  Input: @list = ("the", "weekly", "challenge")
         $char = "e"
  Output: (0, 1, 2)

Example 2

  Input: @list = ("perl", "raku", "python")
         $char = "p"
  Output: (0, 2)

Example 3

  Input: @list = ("abc", "def", "bbb", "bcd")
         $char = "b"
  Output: (0, 2, 3)

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
2. A single character is entered on the command-line, followed by a list of
   words.

=cut
#===============================================================================

use v5.32;          # Enables strictures
use warnings;
use Const::Fast;
use Devel::Assert 'on';
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <char> [<list> ...]
  perl $0

    <char>          A character
    [<list> ...]    A list of words
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 315, Task #1: Find Words (Perl)\n\n";
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
        my ($char, @list) = @ARGV;

        length $char == 1 or error( qq[Invalid char "$char"] );

        printf qq[Input:  \@list = (%s)\n        \$char =  "%s"\n],
               join( ', ', map { qq["$_"] } @list ), $char;

        my $indices = find_indices( \@list, $char );

        printf "Output: (%s)\n", join ', ', @$indices;
    }
}

#-------------------------------------------------------------------------------
sub find_indices
#-------------------------------------------------------------------------------
{
    my ($list, $char) = @_;

    assert length $char == 1;

    my @indices;
    my $re = qr/ $char /x;

    for my $i (0 .. $#$list)
    {
        push @indices, $i if $list->[ $i ] =~ $re;
    }

    return \@indices;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $list_str, $char, $expd_str) = split / \| /x, $line;

        for ($test_name, $list_str, $char, $expd_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @list     = split / \s+ /x, $list_str;
        my $indices  = find_indices( \@list, $char );
        my @expected = split / \s+ /x, $expd_str;

        is_deeply $indices, \@expected, $test_name;
    }

    done_testing;
}

################################################################################

__DATA__
Example 1|the weekly challenge|e|0 1 2
Example 2|perl raku python    |p|0 2
Example 3|abc def bbb bcd     |b|0 2 3
