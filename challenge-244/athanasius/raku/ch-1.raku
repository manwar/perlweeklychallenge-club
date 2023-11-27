use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 244
=========================

TASK #1
-------
*Count Smaller*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to calculate the number of integers smaller than the integer at
each index.

Example 1

  Input: @int = (8, 1, 2, 2, 3)
  Output: (4, 0, 1, 1, 3)

  For index = 0, count of elements less 8 is 4.
  For index = 1, count of elements less 1 is 0.
  For index = 2, count of elements less 2 is 1.
  For index = 3, count of elements less 2 is 1.
  For index = 4, count of elements less 3 is 3.

Example 2

  Input: @int = (6, 5, 4, 8)
  Output: (2, 1, 0, 3)

Example 3

  Input: @int = (2, 2, 2)
  Output: (0, 0, 0)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 244, Task #1: Count Smaller (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@int where { .elems > 0 && .all ~~ Int:D }            #= A list of integers
)
#===============================================================================
{
    "Input:  \@int = (%s)\n".printf: @int.join: ', ';

    my UInt @out = count-smaller( @int );

    "Output:        (%s)\n"\.printf: @out.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-smaller( List:D[Int:D] $ints --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my Int  @sorted = $ints.sort;
    my UInt @out;
            @out.push: @sorted.first: * == $_, :k for @$ints;

    return  @out;
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

        my Int  @int = $int-str.split( / \s+ / ).map: { .Int };
        my UInt @out = count-smaller( @int );
        my UInt @exp = $exp-str.split( / \s+ / ).map: { .Int };

        is-deeply @out, @exp, $test-name;
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
        Example 1|8 1 2 2 3|4 0 1 1 3
        Example 2|6 5 4 8  |2 1 0 3
        Example 3|2 2 2    |0 0 0
        END
}

################################################################################
