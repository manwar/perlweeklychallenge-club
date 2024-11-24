use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 296
=========================

TASK #1
-------
*String Compression*

Submitted by: Mohammad Sajid Anwar

You are given a string of alphabetic characters, $chars.

Write a script to compress the string with run-length encoding, as shown in the
examples.

A compressed unit can be either a single character or a count followed by a
character.

BONUS: Write a decompression function.

Example 1

  Input: $chars = "abbc"
  Output: "a2bc"

Example 2

  Input: $chars = "aaabccc"
  Output: "3ab3c"

Example 3

  Input: $chars = "abcc"
  Output: "ab2c"

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
2. A non-empty string of alphabetic characters to be compressed is entered on
   the command-line.

=end comment
#===============================================================================

use Test;

my regex Alpha { <[ A .. Z a .. z ]> };
my regex Digit { <[ 0 .. 9        ]> };
my regex AlDig { <Alpha> ||  <Digit> };

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 296, Task #1: String Compression (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty string of alphabetic characters

    Str:D $chars where { .chars > 0 && / ^ <Alpha>+ $ / }
)
#===============================================================================
{
    qq[Input:  \$chars = "$chars"].put;

    my Str $compressed = compress( $chars );

    qq[Output: "$compressed"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub compress( Str:D $chars where { / ^ <Alpha>+ $ / } --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $compressed = '';

    $chars ~~ m:g/ (.) {} :my $c = $0; ($c*) /;

    my Str @runs = $/.map: { .Str };

    for @runs -> Str $run
    {
        my UInt $count = $run.chars;

        $compressed ~= $count == 1 ?? $run !! $count ~ $run.substr: 0, 1;
    }

    return $compressed;
}

#-------------------------------------------------------------------------------
sub decompress( Str:D $compressed where { / ^ <AlDig>* <Alpha> $ / } --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $decompressed = '';

    $compressed ~~ m:g/ (<Digit>* <Alpha>) /;

    my Str @runs = $/.map: { .Str };

    for @runs -> Str $run
    {
        $run ~~ / ^ (<Digit>*) (<Alpha>) $ /;

        $decompressed ~= $0 eq '' ?? $1 !! $1 x $0;
    }

    return $decompressed;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $chars, $expected) = $line.split: / \| /;

        for     $test-name, $chars, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $compressed   =   compress( $chars );
        my Str $decompressed = decompress( $compressed );

        is $compressed,   $expected, "$test-name: compress";
        is $decompressed, $chars,    "$test-name: decompress";
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
        Example 1|abbc   |a2bc
        Example 2|aaabccc|3ab3c
        Example 3|abcc   |ab2c
        No runs  |abcdefg|abcdefg
        END
}

################################################################################
