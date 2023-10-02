use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 220
=========================

TASK #1
-------
*Common Characters*

Submitted by: Mohammad S Anwar

You are given a list of words.

Write a script to return the list of common characters (sorted alphabetically)
found in every word of the given list.

Example 1

  Input: @words = ("Perl", "Rust", "Raku")
  Output: ("r")

Example 2

  Input: @words = ("love", "live", "leave")
  Output: ("e", "l", "v")

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Non-alphabetic characters (e.g., the hyphen in "by-laws") should be ignored.

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

subset Char of Str where { / ^ <[ A..Z a..z ]> $ / };

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 220, Task #1: Common Characters (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@words where { .elems > 0 }                              #= A list of words
)
#===============================================================================
{
    "Input:  \@words = (%s)\n".printf: @words.map( { qq["$_"] } ).join: ', ';

    my Char @common-chars = find-common-characters( @words );

    "Output: (%s)\n".printf:    @common-chars.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-common-characters( List:D[Str:D] $words --> Seq:D[Char:D] )
#-------------------------------------------------------------------------------
{
    my Set[Char] $common-chars = make-set( $words[ 0 ] );

    $common-chars ∩= make-set( $_ ) for $words[ 1 .. * ];         # Intersection

    return $common-chars.keys.sort;
}

#-------------------------------------------------------------------------------
sub make-set( Str:D $word --> Set:D[Char:D] )
#-------------------------------------------------------------------------------
{
    return Set[Char].new: $word.split( '' ).grep( Char ).map: { .lc };
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words-str, $exptd-str) = $line.split: / \| /;

        for $test-name, $words-str, $exptd-str                 # Trim whitespace
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Char @expected = $exptd-str.split: / \s+ /;
        my Str  @words    = $words-str.split: / \s+ /;
        my Char @solution = find-common-characters( @words );

        is-deeply @solution, @expected, $test-name;
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
        Example 1 |Perl    Rust          Raku      |r
        Example 2 |love    live          leave     |e l v
        Hyphenated|by-laws whale-blubber water-baby|a b w
        END
}

################################################################################
