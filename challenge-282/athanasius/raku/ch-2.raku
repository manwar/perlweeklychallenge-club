use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 282
=========================

TASK #2
-------
*Changing Keys*

Submitted by: Mohammad Sajid Anwar

You are given an alphabetic string, $str, as typed by user.

Write a script to find the number of times user had to change the key to type
the given string. Changing key is defined as using a key different from the last
used key. The shift and caps lock keys won't be counted.

Example 1

  Input: $str = 'pPeERrLl'
  Output: 3

  p -> P : 0 key change
  P -> e : 1 key change
  e -> E : 0 key change
  E -> R : 1 key change
  R -> r : 0 key change
  r -> L : 1 key change
  L -> l : 0 key change

Example 2

  Input: $str = 'rRr'
  Output: 0

Example 3

  Input: $str = 'GoO'
  Output: 1

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
2. A single, alphabetic, string is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 282, Task #2: Changing Keys (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str where / ^ <[ A..Z a..z]>* $ /             #= An alphabetic string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $key-changes = count-key-changes( $str );

    "Output: $key-changes".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-key-changes( Str:D $str where / ^ <[ A..Z a..z ]>* $ / --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $changes = 0;
    my Str  @chars   = $str.split: '', :skip-empty;

    for 1 .. @chars.end -> UInt $i
    {
        ++$changes unless @chars[ $i - 1 ].lc eq @chars[ $i ].lc;
    }

    return $changes;
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

        my UInt $key-changes = count-key-changes( $str );

        is $key-changes, $expected.Int, $test-name;
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
        Example 1|pPeERrLl|3
        Example 2|rRr     |0
        Example 3|GoO     |1
        Empty    |        |0
        END
}

################################################################################
