use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 238
=========================

TASK #1
-------
*Running Sum*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to return the running sum of the given array. The running sum can
be calculated as sum[i] = num[0] + num[1] + …. + num[i].

Example 1

  Input: @int = (1, 2, 3, 4, 5)
  Output: (1, 3, 6, 10, 15)

Example 2

  Input: @int = (1, 1, 1, 1, 1)
  Output: (1, 2, 3, 4, 5)

Example 3

  Input: @int = (0, -1, 1, 2)
  Output: (0, -1, 0, 2)

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
2. If the first element in the input list is negative, it must be preceded by
   "--" to distinguish it from a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 238, Task #1: Running Sum (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@int where { .elems > 0 && .all ~~ Int:D }  #= A non-empty list of integers
)
#===============================================================================
{
    my Int  @sum = find-running-sum( @int );
    my Str (@int-str, @sum-str);

    for 0 .. @int.end -> UInt $i
    {
        my UInt $width = max( @int[ $i ].chars, @sum[ $i ].chars );

        @int-str.push: '%*s'.sprintf: $width, @int[ $i ];
        @sum-str.push: '%*s'.sprintf: $width, @sum[ $i ];
    }

    "Input: \@int = (%s)\n".printf: @int-str.join: ', ';
    "Output:       (%s)\n"\.printf: @sum-str.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-running-sum( List:D[Int:D] $ints --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my Int @sum = $ints[ 0 ];

    for 1 .. $ints.end -> UInt $i
    {
        @sum.push: $ints[ $i ] + @sum[ *-1 ];
    }

    return @sum;
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

        my Int @int = $int-str.split( / \s+ / ).map: { .Int };
        my Int @exp = $exp-str.split( / \s+ / ).map: { .Int };
        my Int @sum = find-running-sum( @int );

        is-deeply @sum, @exp, $test-name;
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
        Example 1| 1  2 3  4 5| 1  3 6 10 15
        Example 2| 1  1 1  1 1| 1  2 3  4  5
        Example 3| 0 -1 1  2  | 0 -1 0  2
        Negatives|-3 -2 6 -1 4|-3 -5 1  0  4
        END
}

################################################################################
