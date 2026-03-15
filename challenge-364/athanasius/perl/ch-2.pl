#!perl

################################################################################
=comment

Perl Weekly Challenge 364
=========================

TASK #2
-------
*Goal Parser*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to interpret the given string using Goal Parser.

| The Goal Parser interprets "G" as the string "G", "()" as the string "o", and
| "(al)" as the string "al". The interpreted strings are then concatenated in
| the original order.

Example 1

  Input: $str = "G()(al)"
  Output: "Goal"

  G    -> "G"
  ()   -> "o"
  (al) -> "al"

Example 2

  Input: $str = "G()()()()(al)"
  Output: "Gooooal"

  G       -> "G"
  four () -> "oooo"
  (al)    -> "al"

Example 3

  Input: $str = "(al)G(al)()()"
  Output: "alGaloo"

  (al) -> "al"
  G    -> "G"
  (al) -> "al"
  ()   -> "o"
  ()   -> "o"

Example 4

  Input: $str = "()G()G"
  Output: "oGoG"

  () -> "o"
  G  -> "G"
  () -> "o"
  G  -> "G"

Example 5

  Input: $str = "(al)(al)G()()"
  Output: "alalGoo"

  (al) -> "al"
  (al) -> "al"
  G    -> "G"
  ()   -> "o"
  ()   -> "o"

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
2. A single string of tokens is entered on the command-line. Valid tokens are:
   "G", "()", and "(al)".

Reference
---------
"1678. Goal Parser Interpretation",
 https://leetcode.com/problems/goal-parser-interpretation/

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string of the tokens "G", "()", and "(al)"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 364, Task #2: Goal Parser (Perl)\n\n";
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
        my $str  = $ARGV[0];
        my $goal = parse( $str );

        print qq[Input:  \$str = "$str"\n];
        print qq[Output: "$goal"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub parse
#-------------------------------------------------------------------------------
{
    my ($str) =  @_;

    $str =~ / ^ (?:G|\(\)|\(al\))* $ /x
                or error( qq["$str" is not a valid input string] );

    $str =~ s/ \( a l \) /al/gx;        # "(al)" --> "al"
    $str =~ s/ \(     \)  /o/gx;        # "()"   --> "o"

    $str =~ / ^ (?:G|o|al)* $ /x or die qq[Invalid output "$str"];

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

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $goal = parse( $str );

        is $goal, $expected, $test_name;
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
Example 1|G()(al)      |Goal
Example 2|G()()()()(al)|Gooooal
Example 3|(al)G(al)()()|alGaloo
Example 4|()G()G       |oGoG|o
Example 5|(al)(al)G()()|alalGoo
