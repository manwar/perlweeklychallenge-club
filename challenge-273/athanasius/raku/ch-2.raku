use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 273
=========================

TASK #2
-------
*B After A*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to return true if there is at least one b, and no a appears after
the first b.

Example 1

  Input: $str = "aabb"
  Output: true

Example 2

  Input: $str = "abab"
  Output: false

Example 3

  Input: $str = "aaa"
  Output: false

Example 4

  Input: $str = "bbb"
  Output: true

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Character comparisons are NOT case-sensitive; i.e., "A" is the same character as
"a", and "B" is the same character as "b".

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input string is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 273, Task #2: B After A (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Bool $b-after-a = b-after-a( $str );

    "Output: %s\n".printf: $b-after-a ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub b-after-a( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    return so $str ~~ m:i/ ^ <-[b]>* b <-[a]>* $ /;
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

        my Str $b-after-a = b-after-a( $str ) ?? 'true' !! 'false';

        is $b-after-a, $expected, $test-name;
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
        Example 1  |aabb |true
        Example 2  |abab |false
        Example 3  |aaa  |false
        Example 4  |bbb  |true
        Uppercase 1|AABB |true
        Uppercase 2|aBAb |false
        Uppercase 3|aAa  |false
        Uppercase 4|Bbb  |true
        First B    |ababx|false
        Second B   |abxba|false
        END
}

################################################################################
