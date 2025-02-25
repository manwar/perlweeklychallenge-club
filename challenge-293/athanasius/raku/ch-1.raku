use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 293
=========================

TASK #1
-------
*Similar Dominos*

Submitted by: Mohammad Sajid Anwar

You are given a list of dominos, @dominos.

Write a script to return the number of dominoes that are similar to any other
domino.

    $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a = c and
    b = d) or (a = d and b = c).

Example 1

  Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
  Output: 2

  Similar Dominos: $dominos[0], $dominos[1]

Example 2

  Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
  Output: 3

  Similar Dominos: $dominos[0], $dominos[1], $dominos[3]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
A spot can be any single digit.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of domino-strings is entered on the command-line. Each
   domino-string is a pair of single digits separated by a comma, with optional
   whitespace. E.g., "1, 3" "3, 0" "0, 2" "0, 0" "9, 4"

=end comment
#===============================================================================

use Test;

subset Spot of UInt where 0 <= * <= 9;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 293, Task #1: Similar Dominos (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of domino-strings, e.g., "1, 3"

    *@domino-strs where { .elems > 0 }
)
#===============================================================================
{
    my Array[Spot] @dominoes = read-dominoes( @domino-strs );

    "Input:  \@dominoes = (%s)\n".printf:
              @dominoes.map( { "[$_[ 0 ], $_[ 1 ]]" } ).join: ', ';

    my UInt  $similar = find-similar-dominoes( @dominoes );

    "Output: $similar".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-similar-dominoes( List:D[Domino:D] $dominoes --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt %sets;

    while @$dominoes
    {    
        my Array[Spot] $domino = $dominoes.shift;
        my Spot        $lhs    = $domino[ 0 ];
        my Spot        $rhs    = $domino[ 1 ];
        my Str         $key    = $lhs <= $rhs ?? "$lhs:$rhs" !! "$rhs:$lhs";

        ++%sets{ $key };
    }

    my UInt $similar = 0;

    for %sets<>:v -> UInt $count
    {
        $similar += $count if $count > 1;
    }

    return $similar;
}

#-------------------------------------------------------------------------------
sub read-dominoes( List:D[Str:D] $domino-strs --> List:D[Spot:D] )
#-------------------------------------------------------------------------------
{
    my Array[Spot] @dominoes;

    for @$domino-strs -> Str $str
    {
        $str ~~ / ^ \s* (\d) \s* \, \s* (\d) \s* $ /
            or error( qq[Invalid domino string "$str"] );

        my Spot @domino = +$0, +$1;

        @dominoes.push: @domino;
    }

    return @dominoes;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $domino-str, $expected) = $line.split: / \| /;

        for     $test-name, $domino-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str         @pairs    = $domino-str.split: / \s* \; \s* /;
        my Array[Spot] @dominoes = read-dominoes( @pairs );
        my UInt        $similar  = find-similar-dominoes( @dominoes );

        is $similar, $expected.Int, $test-name;
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
        Example 1|1, 3; 3, 1; 2, 4; 6, 8      |2
        Example 2|1, 2; 2, 1; 1, 1; 1, 2; 2, 2|3
        END
}

################################################################################
