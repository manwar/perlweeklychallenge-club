use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 319
=========================

TASK #1
-------
*Word Count*

Submitted by: Mohammad Sajid Anwar

You are given a list of words containing alphabetic characters only.

Write a script to return the count of words either starting with a vowel or
ending with a vowel.

Example 1

  Input: @list = ("unicode", "xml", "raku", "perl")
  Output: 2

  The words are "unicode" and "raku".

Example 2

  Input: @list = ("the", "weekly", "challenge")
  Output: 2

Example 3

  Input: @list = ("perl", "python", "postgres")
  Output: 0

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
2. A non-empty list of words is entered on the command-line.

Notes
-----
1. From Example 2, it appears that "y" is not considered a vowel, even when (as
   there) it functions as one.
2. Vowels are specified in lowercase, and are assumed to have uppercase counter-
   parts.
3. If support for non-English European languages is wanted, vowels with dia-
   critics ("è", "é", "ê", etc.) may be added to $VOWELS.
4. Non-alphabetic chars in the input are silently ignored.

=end comment
#===============================================================================

use Test;

my Set $VOWELS = set < a e i o u >;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 319, Task #1: Word Count (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of non-empty words

    *@list where { .elems > 0 && .all.chars > 0 }
)
#===============================================================================
{
    "Input:  \@list = (%s)\n".printf: @list.map( { qq["$_"] } ).join: ', ';

    my UInt $count = count-words( @list );

    "Output: $count".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-words( List:D[Str:D] $list --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count = 0;

    for @$list -> Str $word
    {
        my Str $first = $word.substr:   0, 1;
        my Str $last  = $word.substr: *-1;

        ++$count if $first.lc ∈ $VOWELS || $last.lc ∈ $VOWELS;
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
        my Str ($test-name, $list-str, $expected) = $line.split: / \| /;

        for     $test-name, $list-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @list  = $list-str.split: / \s+ /, :skip-empty;
        my UInt $count = count-words( @list );

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
        Example 1|unicode xml raku perl|2
        Example 2|the weekly challenge |2
        Example 3|perl python postgres |0
        Capitals |Unicode xml RAKU Perl|2
        END
}

################################################################################
