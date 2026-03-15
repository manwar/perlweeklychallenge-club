use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string of tokens is entered on the command-line. Valid tokens are:
   "G", "()", and "(al)".

Reference
---------
"1678. Goal Parser Interpretation",
 https://leetcode.com/problems/goal-parser-interpretation/

=end comment
#===============================================================================

use Test;

subset Result of List where (Array[Int], Array[Str]);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 364, Task #2: Goal Parser (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string of the tokens "G", "()", and "(al)"

    Str:D $str where * ~~ / ^ [ G || \( \) || \( al \) ]* $ /
)
#===============================================================================
{
    my Str $goal = parse( $str );

    qq[Input:  \$str = "$str"].put;
    qq[Output: "$goal"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub parse
(
    Str:D $str where * ~~ / ^ [ G || \( \) || \( al \) ]* $ /
--> Str:D
)
#-------------------------------------------------------------------------------
{
    my Str $goal = $str;

    $goal ~~ s:g/ \( al \) /al/;       # "(al)" --> "al"
    $goal ~~ s:g/ \(    \)  /o/;       # "()"   --> "o"

    $goal ~~ / ^ [ G || o || al ]* $ / or die qq[Invalid output "$str"];

    return $goal;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my $goal = parse( $str );

        is $goal, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    exit 0;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|G()(al)      |Goal
        Example 2|G()()()()(al)|Gooooal
        Example 3|(al)G(al)()()|alGaloo
        Example 4|()G()G       |oGoG|o
        Example 5|(al)(al)G()()|alalGoo
        END
}

################################################################################
