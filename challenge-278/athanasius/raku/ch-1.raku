use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 278
=========================

TASK #1
-------
*Sort String*

Submitted by: Mohammad Sajid Anwar

You are given a shuffle string, $str.

Write a script to return the sorted string.

    A string is shuffled by appending word position to each word.

Example 1

  Input: $str = "and2 Raku3 cousins5 Perl1 are4"
  Output: "Perl and Raku are cousins"

Example 2

  Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
  Output: "Python is the most popular guest language"

Example 3

  Input: $str = "Challenge3 The1 Weekly2"
  Output: "The Weekly Challenge"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A "shuffle[d] string" is entered as a single argument on the command-line.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 278, Task #1: Sort String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str   #= Shuffled string in which each word has its position appended
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my Str $sorted = sort-sentence( $str );

    qq[Output:       "$sorted"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub sort-sentence( Str:D $str --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @words = $str.split: / \s+ /, :skip-empty;
    my Str @sorted;

    for @words -> Str $shuffle-word
    {
        $shuffle-word ~~ / ^ ( .* \D ) ( \d+ ) $ /
            or  error( qq["$shuffle-word" is not a valid shuffle word] );

        my Str $word = ~$0;

        +$1 ~~ Pos:D
            or  error( qq["$shuffle-word" does not end in a positive integer] );
        my UInt $ord = +$1;

        @sorted[ $ord ]:exists
            and error( "Duplicate position $ord found" );

        @sorted[ $ord ] = $word;
    }

    for 1 .. @sorted.end -> UInt $i
    {
        @sorted[ $i ]:exists
            or  error( "No word found for position $i" );
    }

    return @sorted[ 1 .. * ].join: ' ';
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

        my Str $sorted = sort-sentence( $str );

        is $sorted, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "\nERROR: $message".put;

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
    my Str $data = q:to/END/;
        Example 1|and2 Raku3 cousins5 Perl1 are4|Perl and Raku are cousins
        Example 2|guest6 Python1 most4 the3 popular5 is2 language7             \
                 |Python is the most popular guest language
        Example 3|Challenge3 The1 Weekly2|The Weekly Challenge
        END

    $data ~~ s:g/ \\ \n \s* / /;                 # Concatenate backslashed lines

    return $data;
}

################################################################################
