use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 222
=========================

TASK #2
-------
*Last Member*

Submitted by: Mohammad S Anwar

You are given an array of positive integers, @ints.

Write a script to find the last member if found otherwise return 0. Each turn
pick 2 biggest members (x, y) then decide based on the following conditions,
continue this until you are left with 1 member or none.

    a) if x == y then remove both members

    b) if x != y then remove both members and add new member (y-x)

Example 1:

  Input: @ints = (2, 7, 4, 1, 8, 1)
  Output: 1

  Step 1: pick 7 and 8, we remove both and add new member 1 => (2, 4, 1, 1, 1).
  Step 2: pick 2 and 4, we remove both and add new member 2 => (2, 1, 1, 1).
  Step 3: pick 2 and 1, we remove both and add new member 1 => (1, 1, 1).
  Step 4: pick 1 and 1, we remove both => (1).

Example 2:

  Input: @ints = (1)
  Output: 1

Example 3:

  Input: @ints = (1, 1)
  Output: 0

  Step 1: pick 1 and 1, we remove both and we left with none.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. A "positive integer" is an integer greater than zero.
2. Condition b) means: 
      if x < y then remove both members and add new member (y-x)
   -- so that the new member is always a positive integer.

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 222, Task #2: Last Member (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Pos:D }  #= A list of positive integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt  $last-member = find-last-member( @ints );

    "Output: $last-member".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-last-member( List:D[Pos:D] $ints --> UInt:D )
#-------------------------------------------------------------------------------
{
    my Pos @list = $ints.sort;

    while @list.elems > 1
    {
        my Pos $y = @list.pop;
        my Pos $x = @list.pop;

        if $x < $y
        {
            @list.unshift: $y - $x;
            @list.= sort;
        }
    }

    return @list.elems ?? @list[ 0 ] !! 0;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected) = $line.split: / \| /;

        for $test-name, $ints-str, $expected                   # Trim whitespace
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos  @ints = $ints-str.split( / \s+ / ).map: { .Int };
        my UInt $last = find-last-member( @ints );

        is $last, $expected.Int, $test-name;
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
        Example 1|2 7 4 1 8 1|1
        Example 2|1          |1
        Example 3|1 1        |0
        END
}

################################################################################
