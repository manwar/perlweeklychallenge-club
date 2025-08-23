use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 335
=========================

TASK #1
-------
*Common Characters*

Submitted by: Mohammad Sajid Anwar

You are given an array of words.

Write a script to return all characters that is in every word in the given array
including duplicates.

Example 1

  Input: @words = ("bella", "label", "roller")
  Output: ("e", "l", "l")

Example 2

  Input: @words = ("cool", "lock", "cook")
  Output: ("c", "o")

Example 3

  Input: @words = ("hello", "world", "pole")
  Output: ("l", "o")

Example 4

  Input: @words = ("abc", "def", "ghi")
  Output: ()

Example 5

  Input: @words = ("aab", "aac", "aaa")
  Output: ("a", "a")

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
2. A list of words is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 335, Task #1: Common Characters (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@words where { .all ~~ Str:D }             #= A list of words
)
#===============================================================================
{
    "Input:  @words = (%s)\n".printf: @words\.map( { qq["$_"] } ).join: ', ';

    my Str @common = find-common-chars( @words );

    "Output: (%s)\n"\        .printf: @common.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-common-chars( List:D[Str:D] $words --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my BagHash $common = BagHash.new;

    if $words.elems > 0
    {
        $common.add( $_ ) for $words[ 0 ].split: '', :skip-empty;

        for 1 .. $words.end -> UInt $i
        {
            my Bag $chars = Bag.new: $words[ $i ].split: '', :skip-empty;

            $common ∩= $chars;           # Keep only the intersection
        }
    }

    return $common ?? |$common.kxxv.sort !! ();
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $words-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @words    = $words-str.split: / \s+ /, :skip-empty;
        my Str @common   = find-common-chars( @words );
        my Str @expected = $exp-str\ .split: / \s+ /, :skip-empty;

        is-deeply @common, @expected, $test-name;
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
        Example 1|bella label roller|e l l
        Example 2|cool  lock  cook  |c o
        Example 3|hello world pole  |l o
        Example 4|abc   def   ghi   |
        Example 5|aab   aac   aaa   |a a
        END
}

################################################################################
