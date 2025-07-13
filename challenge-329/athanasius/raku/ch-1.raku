use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 329
=========================

TASK #1
-------
*Counter Integers*

Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and digits.

Write a script to replace every non-digit character with a space and then return
all the distinct integers left.

Example 1

  Input: $str = "the1weekly2challenge2"
  Output: 1, 2

  2 is appeared twice, so we count it one only.

Example 2

  Input: $str = "go21od1lu5c7k"
  Output: 21, 1, 5, 7

Example 3

  Input: $str = "4p3e2r1l"
  Output: 4, 3, 2, 1

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
2. A string containing only digits and lower-case English letters is entered on
   the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 329, Task #1: Counter Integers (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string containing only digits and lower-case English letters

    Str:D $str where / ^ <[ a..z 0..9 ]>* $ /
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my UInt @ints = find-ints( $str );

    qq[Output: %s\n].printf: @ints.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-ints( Str:D $str where / ^ <[ a..z 0..9 ]>* $ / --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @ints;
    my UInt %dict{UInt};

    for $str.split: / <-[ 0..9 ]>+ /, :skip-empty -> Str $dig-str
    {
        my UInt $int = +$dig-str;

        @ints.push: $int if ++%dict{ $int } == 1;
    }

    return @ints;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected-str) = $line.split: / \| /;

        for     $test-name, $str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @ints = find-ints( $str );
        my UInt @exp  = $expected-str.split( / \s+ / ).map: { .Int };

        is-deeply @ints, @exp, $test-name;
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
        Example 1|the1weekly2challenge2| 1 2
        Example 2|go21od1lu5c7k        |21 1 5 7
        Example 3|4p3e2r1l             | 4 3 2 1
        END
}

################################################################################
