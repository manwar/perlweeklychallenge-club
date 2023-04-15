use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 212
=========================

TASK #1
-------
*Jumping Letters*

Submitted by: Mohammad S Anwar

You are given a word having alphabetic characters only, and a list of positive
integers of the same length

Write a script to print the new word generated after jumping forward each letter
in the given word by the integer in the list. The given list would have exactly
the number as the total alphabets in the given word.

Example 1

  Input: $word = 'Perl' and @jump = (2,22,19,9)
  Output: Raku

  'P' jumps 2 place forward and becomes 'R'.
  'e' jumps 22 place forward and becomes 'a'.
     (jump is cyclic i.e. after 'z' you go back to 'a')
  'r' jumps 19 place forward and becomes 'k'.
  'l' jumps 9 place forward and becomes 'u'.

Example 2

  Input: $word = 'Raku' and @jump = (24,4,7,17)
  Output: 'Perl'

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Note
----
Case is preserved in each jump.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 212, Task #1: Jumping Letters (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty word containing alphabetic characters only

    Str:D $word where { / ^ <[ A .. Z a .. z ]>+ $ / },

    #| A list of positive integers of the same length as $word

    *@jump where { .all ~~ Pos:D && .elems == $word.chars }
)
#===============================================================================
{
    "Input:  \$word = '%s' and \@jump = (%s)\n".printf: $word, @jump.join: ', ';

    "Output: '%s'\n".printf: jump-letters( $word, @jump );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub jump-letters
(
    Str:D         $word where { / ^ <[ A .. Z a .. z ]>+ $ / },
    List:D[Pos:D] $jump where { .elems == $word.chars }
--> Str:D
)
#-------------------------------------------------------------------------------
{
    my Str $new-word = '';

    for 0 .. $jump.end -> UInt $i
    {
        my Str  $letter    =   $word.substr: $i, 1;
        my Bool $is-uc     =  'A'.ord <= $letter.ord <= 'Z'.ord;
        my UInt $offset    = ( $is-uc ?? 'A' !! 'a' ).ord;
        my UInt $value     =   $letter.ord - $offset;
        my UInt $new-value = ( $value + $jump[ $i ] ) % 26;
                $new-word ~= ( $new-value + $offset ).chr;
    }

    return $new-word;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $word, $jump-str, $expected) = $line.split: / \| /;

        for $test-name, $word, $jump-str           # Trim whitespace
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos @jump = $jump-str.split( / \, \s* / ).map: { .Int };
        my Str $got  = jump-letters( $word, @jump );

        is $got, $expected, $test-name;
    }

    done-testing;
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
        Example 1 |Perl      | 2,22,19, 9               |Raku
        Example 2 |Raku      |24, 4, 7,17               |Perl
        One letter|B         |25                        |A
        Me        |Imperlmonk|18, 7,18,22,22,15,6,20,7,8|Athanasius
        END
}

################################################################################
