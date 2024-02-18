use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 255
=========================

TASK #1
-------
*Odd Character*

Submitted by: Mohammad Sajid Anwar

You are given two strings, $s and $t. The string $t is generated using the
shuffled characters of the string $s with an additional character.

Write a script to find the additional character in the string $t.

Example 1

  Input: $s = "Perl" $t = "Preel"
  Output: "e"

Example 2

  Input: $s = "Weekly" $t = "Weeakly"
  Output: "a"

Example 3

  Input: $s = "Box" $t = "Boxy"
  Output: "y"

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
2. If CASE-SENSITIVE is set to True, "P" and "p" (for example) are treated as
   different characters; otherwise, they are treated as the same character.

=end comment
#===============================================================================

use Test;

subset Char of Str where { .chars == 1 };

my Bool constant ASSERT         = True;         # Perform optional sanity checks
my Bool constant CASE-SENSITIVE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 255, Task #1: Odd Character (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $s,       #= A string
    Str:D $t        #= A string containing the chars of s with 1 additional char
)
#===============================================================================
{
    qq[Input:  \$s = "$s" \$t = "$t"].put;

    my Char $odd-char = find-odd-character( $s, $t );

    qq[Output: "$odd-char"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-odd-character( Str:D $s, Str:D $t --> Char:D )
#-------------------------------------------------------------------------------
{
    $t.chars == $s.chars + 1
        or error( '$t must be exactly 1 character longer than $s' );

    my BagHash[Char] $s-chars = BagHash[Char].new:
        $s.split( '', :skip-empty ).map: { CASE-SENSITIVE ?? $_ !! .lc };

    my BagHash[Char] $t-chars = BagHash[Char].new:
        $t.split( '', :skip-empty ).map: { CASE-SENSITIVE ?? $_ !! .lc };

    $s-chars ⊂ $t-chars                                         # Strict subset
        or error( 'The chars in $s are not a subset of the chars in $t' );

    my Pair @odd-chars = $t-chars (-) $s-chars;                 # Set difference

    if ASSERT                                                   # Sanity checks
    {
        @odd-chars.elems      >  0 or error( 'No odd character found' );
        @odd-chars.elems      == 1 or error( 'More than 1 odd char found' );
        @odd-chars[ 0 ].value == 1 or error( 'More than 1 odd character "' ~
                                              @odd-chars[ 0 ].key ~ '" found' );
    }

    return @odd-chars[ 0 ].key;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $s, $t, $expected) = $line.split: / \| /;

        for     $test-name, $s, $t, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Char $odd-char = find-odd-character( $s, $t );

        is $odd-char, $expected, $test-name;
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
        Example 1|Perl  |Preel  |e
        Example 2|Weekly|Weeakly|a
        Example 3|Box   |Boxy   |y
        Empty    |      |q      |q
        END
}

################################################################################
