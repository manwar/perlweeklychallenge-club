#!perl

################################################################################
=comment

Perl Weekly Challenge 278
=========================

TASK #2
-------
*Reverse Word*

Submitted by: Mohammad Sajid Anwar

You are given a word, $word and a character, $char.

Write a script to replace the substring up to and including $char with its
characters sorted alphabetically. If the $char doesn't exist then DON'T do
anything.

Example 1

  Input: $str = "challenge", $char = "e"
  Output: "acehllnge"

Example 2

  Input: $str = "programming", $char = "a"
  Output: "agoprrmming"

Example 3

  Input: $str = "champion", $char = "b"
  Output: "champion"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. From Example 1 it appears that the substring to be sorted extends from the
   start of $word up to (and including) the FIRST occurrence of $char ONLY.
2. Character-matching is case-sensitive, so, e.g., "E" does NOT match "e".
3. In alphabetical sorting, "Z" comes before "a".

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A word and a single character are entered as two positional arguments on the
   command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <word> <char>
  perl $0

    <word>    A word
    <char>    A single character
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 278, Task #2: Reverse Word (Perl)\n\n";
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
    elsif ($argc == 2)
    {
        my ($word, $char) = @ARGV;

        length $char == 1 or error( qq[Invalid character "$char"] );

        print qq[Input: \$word = "$word", \$char = "$char"\n];

        my $reversed = reverse_word( $word, $char );

        print qq[Output:        "$reversed"\n];
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub reverse_word
#-------------------------------------------------------------------------------
{
    my ($word, $char) = @_;

    length $char == 1 or die qq[Invalid character "$char"];

    my $reversed = $word;

    if ($word =~ / ^ (.*? $char) (.*) $ /x)
    {
        $reversed = join( '', sort split '', $1 ) . $2;
    }
  # else leave the word unchanged

    return $reversed;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $word, $char, $expected) = split / \| /x, $line;

        for ($test_name, $word, $char, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $reversed = reverse_word( $word, $char );

        is $reversed, $expected, $test_name;
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
Example 1 |challenge  |e|acehllnge
Example 2 |programming|a|agoprrmming
Example 3 |champion   |b|champion
Final char|champagne  |e|aaceghmnp
First char|xabc       |x|xabc
Empty     |           |a|
One char  |t          |t|t
Reversed  |zyxwvutsrqp|p|pqrstuvwxyz
