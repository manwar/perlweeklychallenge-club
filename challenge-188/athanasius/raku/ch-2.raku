use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 188
=========================

TASK #2
-------
*Total Zero*

Submitted by: Mohammad S Anwar

You are given two positive integers $x and $y.

Write a script to find out the number of operations needed to make both ZERO.
Each operation is made up either of the followings:

  $x = $x - $y if $x >= $y

  or

  $y = $y - $x if $y >= $x (using the original value of $x)

Example 1

  Input: $x = 5, $y = 4
  Output: 5

Example 2

  Input: $x = 4, $y = 6
  Output: 3

Example 3

  Input: $x = 2, $y = 5
  Output: 4

Example 4

  Input: $x = 3, $y = 1
  Output: 3

Example 5

  Input: $x = 7, $y = 4
  Output: 5

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no arguments are given on the command line, the test suite is run.

Assumptions
-----------
1. A "positive integer" is an integer > 0.

2. The requirement to make BOTH $x and $y zero does not seem correct. I have
   solved the task by making ONE of $x and $y zero, *which gives the solutions
   in the Examples*. I have also ignored the parenthetical "using the original
   value of $x" in the task description, as I don't know what it means.

   (If one seeks to change BOTH $x = 5 and $y = 4 to zero, it would seem to
   require at least 6 steps, not 5 as given in Example 1:

          -------------------------
            x  y  Step  Operation
          -------------------------
            5  4
                    1    x -= y
            1  4
                    2    y -= x
            1  3
                    3    y -= x
            1  2
                    4    y -= x
            1  1
                    5    x -= y
            0  1
                    6      ??
            0  0
          -------------------------

   and I don't know what the 6th step would be.)

=end comment
#==============================================================================

use Test;

subset Pos of Int where * > 0;

my UInt constant $TEST-FIELDS = 4;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 188, Task #2: Total Zero (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    Pos:D $x,                      #= A positive integer
    Pos:D $y                       #= A positive integer
)
#==============================================================================
{
    "Input:  \$x = $x, \$y = $y".put;

    "Output: %d\n".printf: count-operations( $x, $y );
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $x, $y, $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS; #, :skip-empty;

        is count-operations( +$x, +$y ), $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub count-operations( Pos:D $x, Pos:D $y --> Pos:D )
#------------------------------------------------------------------------------
{
    my UInt $xx    = $x;
    my UInt $yy    = $y;
    my UInt $count = 0;

    while $xx > 0 && $yy > 0
    {
        if  $xx >= $yy
        {
            $xx -= $yy;
        }
        else
        {
            $yy -= $xx;
        }

        ++$count;
    }

    return $count;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1, 5, 4, 5
        Example 2, 4, 6, 3
        Example 3, 2, 5, 4
        Example 4, 3, 1, 3
        Example 5, 7, 4, 5
        END
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
