use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 275
=========================

TASK #1
-------
*Broken Keys*

Submitted by: Mohammad Sajid Anwar

You are given a sentence, $sentence and list of broken keys @keys.

Write a script to find out how many words can be typed fully.

Example 1

  Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
  Output: 0

Example 2

  Input: $sentence = "Perl and Raku", @keys = ('a')
  Output: 1

  Only Perl since the other word two words contain 'a' and can't be typed fully.

Example 3

  Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
  Output: 2

Example 4

  Input: $sentence = "The joys of polyglottism", @keys = ('T')
  Output: 2

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input sentence is entered as an unnamed (positional) argument on the
   command-line, followed by a string comprising a list of the broken keys.

=end comment
#===============================================================================

use Test;

my constant %TWIN-KEYS =
{ 
    '`' => '~',  1  => '!',  2  => '@',  3   => '#',  4  => '$', 5   => '%', 
     6  => '^',  7  => '&',  8  => '*',  9   => '(',  0  => ')', '-' => '_',
    '=' => '+', '[' => '{', ']' => '}', '\\' => '|', ';' => ':', "'" => '"',
    ',' => '<', '.' => '>', '/' => '?'
};
my constant %TWIN = %TWIN-KEYS, %TWIN-KEYS.antipairs;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 275, Task #1: Broken Keys (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $sentence,                #= A sentence
    Str:D $broken-keys              #= A string comprising a list of broken keys
)
#===============================================================================
{
    my Str @keys = $broken-keys.split: '', :skip-empty;

    qq[Input:  \$sentence = "%s", \@keys = (%s)\n].printf:
        $sentence, @keys.map( { qq['$_'] } ).join: ', ';

    my UInt $count = can-be-typed( $sentence, @keys );

    "Output: $count".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub can-be-typed( Str:D $sentence, List:D[Str:D] $keys --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count       = 0;
    my Str  @words       = $sentence.split: / \s+ /, :skip-empty;
    my Str  @broken-keys = @$keys;

    for @$keys -> Str $key
    {
        @broken-keys.push: %TWIN{ $key } if %TWIN{ $key }:exists;
    }

    my Str   $re-str = @broken-keys.map( { qq['$_'] } ).join: '||';
    my Regex $broken = rx:i/ <$re-str> /;

    for @words -> Str $word
    {
        ++$count if $word ~~ / \w / && $word !~~ $broken;
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $sentence, $keys-str, $expected) =
                $line.split: / \| /;

        for     $test-name, $sentence, $keys-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @keys  = $keys-str.split: '', :skip-empty;
        my UInt $count = can-be-typed( $sentence, @keys );

        is $count, $expected.Int, $test-name;
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
        Example 1  |Perl Weekly Challenge   |la|0
        Example 2  |Perl and Raku           |a |1
        Example 3  |Well done Team PWC      |lo|2
        Example 4  |The joys of polyglottism|T |2
        Twin keys 1|Perl1 Weekly@ Challenge |!2|1
        Twin keys 2|Perl! Weekly2 Challenge |@1|1
        END
}

################################################################################
