use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single character is entered on the command-line, followed by a list of
   words.

=end comment
#===============================================================================

use Test;

subset Char of Str where .chars == 1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 315, Task #1: Find Words (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Char:D $char,                      #= A character
          *@list                       #= A list of words
)
#===============================================================================
{
    qq[Input:  \@list = (%s)\n        \$char =  "%s"\n].printf:
        @list.map( { qq["$_"] } ).join( ', ' ), $char;

    my UInt @indices = find-indices( @list, $char );

    "Output: (%s)\n".printf: @indices.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-indices( List:D[Str:D] $list, Char:D $char --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt  @indices;
    my regex R { $char };

    for 0 .. $list.end -> UInt $i
    {
        @indices.push: $i if $list[ $i ] ~~ &R;
    }

    return @indices;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $list-str, $char, $expd-str) = $line.split: / \| /;

        for     $test-name, $list-str, $char, $expd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @list     = $list-str.split: / \s+ /, :skip-empty;
        my UInt @indices  = find-indices( @list, $char );
        my UInt @expected = $expd-str.split( / \s+ /, :skip-empty )
                                     .map: { .Int };

        is-deeply @indices, @expected, $test-name;
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
        Example 1|the weekly challenge|e|0 1 2
        Example 2|perl raku python    |p|0 2
        Example 3|abc def bbb bcd     |b|0 2 3
        END
}

################################################################################
