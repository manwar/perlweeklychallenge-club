use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 254
=========================

TASK #2
-------
*Reverse Vowels*

Submitted by: Mohammad S Anwar

You are given a string, $s.

Write a script to reverse all the vowels (a, e, i, o, u) in the given string.

Example 1

  Input: $s = "Raku"
  Output: "Ruka"

Example 2

  Input: $s = "Perl"
  Output: "Perl"

Example 3

  Input: $s = "Julia"
  Output: "Jaliu"

Example 4

  Input: $s = "Uiua"
  Output: "Auiu"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Note
----
It appears from Example 4 that a new vowel placed into position i of the string
is capitaltalized if and only if the vowel originally in position i was itself
capitalized.

=end comment
#===============================================================================

use Test;

my constant @UC-VOWELS = < A E I O U >;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 254, Task #2: Reverse Vowels (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $s                            #= A string
)
#===============================================================================
{
    qq[Input:  \$s = "$s"].put;

    qq[Output:      "%s"\n].printf: reverse-vowels( $s );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub reverse-vowels( Str:D $s --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str  $reversed = '';
    my Str  @chars    = $s.split: '', :skip-empty;
    my UInt @indices;
    my Str  @vowels;

    for 0 .. @chars.end -> UInt $i
    {
        my Str $char = @chars[ $i ];

        if $char.uc eq @UC-VOWELS.any
        {
            @indices.push: $i;
            @vowels\.push: $char.lc;
        }
    }

    for 0 .. @chars.end -> UInt $i
    {
        if @indices.elems > 0 && @indices[ 0 ] == $i
        {
            @indices.shift;

            my Str $vowel = @vowels.pop;
            $vowel       .= uc if @chars[ $i ] eq @UC-VOWELS.any;
            $reversed    ~= $vowel;
        }
        else
        {
            $reversed    ~= @chars[ $i ];
        }
    }

    return $reversed;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $s, $expected) = $line.split: / \| /;

        for     $test-name, $s, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $reversed = reverse-vowels( $s );

        is $reversed, $expected, $test-name;
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
        Example 1|Raku       |Ruka
        Example 2|Perl       |Perl
        Example 3|Julia      |Jaliu
        Example 4|Uiua       |Auiu
        No vowels|Uvwxyz     |Uvwxyz
        Two words|Happy Irene|Heppy Erina
        END
}

################################################################################
