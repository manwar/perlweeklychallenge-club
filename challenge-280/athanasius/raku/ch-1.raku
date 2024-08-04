use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 280
=========================

TASK #1
-------
*Twice Appearance*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, containing lowercase English letters only.

Write a script to print the first letter that appears twice.

Example 1

  Input: $str = "acbddbca"
  Output: "d"

Example 2

  Input: $str = "abccd"
  Output: "c"

Example 3

  Input: $str = "abcdabbb"
  Output: "a"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
Otherwise:
2. The input string is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 280, Task #1: Twice Appearance (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str where / ^ <[ a .. z ]>* $ /     #= A string of lower case letters
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Str $frl = find-first-repeated-letter( $str );

    "Output: %s\n".printf: $frl eq '' ?? '<none>' !! qq["$frl"];
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-first-repeated-letter
(
    Str:D $str where / ^ <[ a .. z ]>* $ /
--> Str:D
)
#-------------------------------------------------------------------------------
{
    my Str  $frl = '';
    my UInt %dict{Str};

    for $str.split( '', :skip-empty ) -> Str $letter
    {
        if ++%dict{ $letter } > 1
        {
            $frl = $letter;
            last;
        }
    }

    return $frl;
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

        my Str $frl = find-first-repeated-letter( $str );

        is $frl, $expected, $test-name;
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
        Example 1 |acbddbca        |d
        Example 2 |abccd           |c
        Example 3 |abcdabbb        |a
        Empty     |                |
        Singletons|abcdefghijklmnop|
        END
}

################################################################################
