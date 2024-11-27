use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 290
=========================

TASK #1
-------
*Double Exist*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find if there exist two indices $i and $j such that:

  1) $i != $j
  2) 0 <= ($i, $j) < scalar @ints
  3) $ints[$i] == 2 * $ints[$j]

Example 1

  Input: @ints = (6, 2, 3, 3)
  Output: true

  For $i = 0, $j = 2
  $ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]

Example 2

  Input: @ints = (3, 1, 4, 13)
  Output: false

Example 3

  Input: @ints = (2, 1, 4, 2)
  Output: true

  For $i = 2, $j = 3
  $ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]

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
2. A non-empty list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to prevent it
   from being interpreted as a command-line flag.
4. If the constant VERBOSE is set to True, and the output of the Task is true,
   the first (i.e., lowest) values of $i and $j that satisfy the required
   conditions are also displayed.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 290, Task #1: Double Exist (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    qq[Input:  \@ints = (%s)\n].printf: @ints.join: ', ';

    my UInt ($i, $j) = double-exists( @ints );

    "Output: %s\n".printf: $i.defined ?? 'true' !! 'false';

    "\n\$i = $i, \$j = $j".put if VERBOSE && $i.defined;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub double-exists( List:D[Int:D] $ints where { .elems > 0 } --> List:D[UInt:_] )
#-------------------------------------------------------------------------------
{
    my UInt @solution;

    L-OUTER:
    for 0 .. $ints.end - 1 -> UInt $i
    {
        for 1 .. $ints.end -> UInt $j
        {
            next if $i == $j;

            if    $ints[ $i ] == 2 * $ints[ $j ]
            {
                @solution = $i, $j;
                last L-OUTER;
            }
            elsif $ints[ $j ] == 2 * $ints[ $i ]
            {
                @solution = $j, $i;
                last L-OUTER;
            }
        }
    }

    return @solution;
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

        my Int   @ints   = $int-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int   @exp    = $exp-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt ($i, $j) = double-exists( @ints );

        if $i.defined
        {
            is $i, @exp[ 0 ], "$test-name: \$i";
            is $j, @exp[ 1 ], "$test-name: \$j";
        }
        else
        {
            is  0, @exp.elems, $test-name;
        }
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
        Example 1| 6 2  3  3  |0 2
        Example 2| 3 1  4 13  |
        Example 3| 2 1  4  2  |0 1
        Negatives|-3 0 -6  5 5|2 0
        END
}

################################################################################
