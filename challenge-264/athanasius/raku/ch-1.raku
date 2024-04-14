use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 264
=========================

TASK #1
-------
*Greatest English Letter*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, made up of only alphabetic characters [a..zA..Z].

Write a script to return the greatest english letter in the given string.

    A letter is greatest if it occurs as lower and upper case. Also letter 'b'
    is greater than 'a' if 'b' appears after 'a' in the English alphabet.

Example 1

  Input: $str = 'PeRlwEeKLy'
  Output: L

  There are two letters E and L that appears as lower and upper.
  The letter L appears after E, so the L is the greatest english letter.

Example 2

  Input: $str = 'ChaLlenge'
  Output: L

Example 3

  Input: $str = 'The'
  Output: ''

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
2. A single string, containing alphabetic characters only, is given on the
   command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 264, Task #1: Greatest English Letter (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string containing alphabetic characters (A-Z, a-z) only

    Str:D $str where / ^ <[ a .. z A .. Z ]>* $ /;
)
#===============================================================================
{
    "Input:  \$str = '$str'".put;

    my Str $gel = find-greatest-English-letter( $str );

    "Output: '$gel'".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-greatest-English-letter( Str:D $str --> Str:D )
#-------------------------------------------------------------------------------
{
    my UInt %letters;
          ++%letters{ $_ } for $str.split: '', :skip-empty;

    my Str $gel = '';
    my Str @uc  = %letters.keys.grep: { / ^ <.upper> $ / };

    for @uc.sort.reverse
    {
        if %letters{ .lc }:exists
        {
            $gel = $_;
            last;
        }
    }

    return $gel;
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

        my Str $gel = find-greatest-English-letter( $str );

        is $gel, $expected, $test-name;
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
        Example 1|PeRlwEeKLy|L
        Example 2|ChaLlenge |L
        Example 3|The       |
        END
}

################################################################################
