use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 230
=========================

TASK #1
-------
*Separate Digits*

Submitted by: Mohammad S Anwar

You are given an array of positive integers.

Write a script to separate the given array into single digits.

Example 1

  Input: @ints = (1, 34, 5, 6)
  Output: (1, 3, 4, 5, 6)

Example 2

  Input: @ints = (1, 24, 51, 60)
  Output: (1, 2, 4, 5, 1, 6, 0)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
A "positive" integer is greater than zero.

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

subset Dig of Int where 0 <= * <= 9;
subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 230, Task #1: Separate Digits (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Pos:D }  #= A list of positive integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Dig @digits = get-digits( @ints );

    "Output: (%s)\n".printf: @digits.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub get-digits( List:D[Pos:D] $ints --> List:D[Dig:D] )
#-------------------------------------------------------------------------------
{
    my Dig @digits;

    for @$ints -> UInt $int
    {
        @digits.push: |$int.split( '', :skip-empty ).map: { .Int };
    }

    return @digits;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $int-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos @ints     = $int-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Dig @digits   = get-digits( @ints );
        my Dig @expected = $exp-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @digits, @expected, $test-name;
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
        Example 1|1 34  5  6|1 3 4 5 6
        Example 2|1 24 51 60|1 2 4 5 1 6 0
        END
}

################################################################################
