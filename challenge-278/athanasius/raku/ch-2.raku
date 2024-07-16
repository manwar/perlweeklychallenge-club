use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

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

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 278, Task #2: Reverse Word (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $word,                                #= A word
    Str:D $char where { .chars == 1 }           #= A single character
)
#===============================================================================
{
    qq[Input: \$word = "$word", \$char = "$char"].put;

    my Str $reversed = reverse-word( $word, $char );

    qq[Output:        "$reversed"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub reverse-word( Str:D $word, Str:D $char where { .chars == 1 } --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $reversed = $word;

    if $word ~~ / ^ ( .*? $char ) ( .* ) $ /
    {
        $reversed = $0.split( '' ).sort.join ~ $1;
    }
  # else leave the word unchanged

    return $reversed;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $word, $char, $expected) = $line.split: / \| /;

        for     $test-name, $word, $char, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $reversed = reverse-word( $word, $char );

        is $reversed, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1 |challenge  |e|acehllnge
        Example 2 |programming|a|agoprrmming
        Example 3 |champion   |b|champion
        Final char|champagne  |e|aaceghmnp
        First char|xabc       |x|xabc
        Empty     |           |a|
        One char  |t          |t|t
        Reversed  |zyxwvutsrqp|p|pqrstuvwxyz
        END
}

################################################################################
