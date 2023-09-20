use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 235
=========================

TASK #1
-------
*Remove One*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out if removing ONLY one integer makes it strictly in-
creasing order.

Example 1

  Input: @ints = (0, 2, 9, 4, 6)
  Output: true

  Removing ONLY 9 in the given array makes it strictly increasing order.

Example 2

  Input: @ints = (5, 1, 3, 2)
  Output: false

Example 3

  Input: @ints = (2, 2, 3)
  Output: true

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The input list must contain at least 2 integers.
2. If more than one solution is possible, the highest number is selected for the
   VERBOSE output.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first element in the input list is negative, it must be preceded by
   "--" to distinguish it from a command-line flag.
3. If VERBOSE is set to True (the default), and the output is True, the value of
   the integer to be removed is also displayed.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 235, Task #1: Remove One (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 1 && .all ~~ Int:D } #= A list of 2 or more integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int $to-remove = remove-one( @ints );

    "Output: %s\n".printf: $to-remove.defined ?? 'True' !! 'False';

    "\nInteger to remove: $to-remove".put if VERBOSE && $to-remove.defined;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub remove-one( List:D[Int:D] $ints where { .elems > 1 } --> Int:D )
#-------------------------------------------------------------------------------
{
    return $ints[ *-1 ] if $ints.elems == 2 || is-ordered( $ints );

    for 0 .. $ints.end -> UInt $i
    {
        my Int $to-remove = $ints[ $i ];
        my Int @sublist   = $ints[ |(0 ..^ $i), |($i ^.. $ints.end) ];

        return $to-remove if is-ordered( @sublist );
    }

    return Nil;
}

#-------------------------------------------------------------------------------
sub is-ordered( List:D[Int:D] $ints --> Bool:D )
#-------------------------------------------------------------------------------
{
    for 0 .. $ints.end - 1 -> UInt $i
    {
        return False if $ints[ $i ] >= $ints[ $i + 1 ];
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints      = $ints-str.split( / \s+ / ).map: { .Int };
        my Int $to-remove = remove-one( @ints );
        my Int $expected  = $exp-str.chars == 0 ?? Nil !! $exp-str.Int;

        is $to-remove, $expected, $test-name;
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
        Example 1| 0  2 9 4 6| 9
        Example 2| 5  1 3 2  |
        Example 3| 2  2 3    | 2
        Min list |-1 -1      |-1
        Ordered  |-1  0 1 2 3| 3
        END
}

################################################################################
