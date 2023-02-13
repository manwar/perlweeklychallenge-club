use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 203
=========================

TASK #1
-------
*Special Quadruplets*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the total special quadruplets for the given array.

  Special Quadruplets are such that satisfies the following 2 rules.
  1) nums[a] + nums[b] + nums[c] == nums[d]
  2) a < b < c < d

Example 1

  Input: @nums = (1,2,3,6)
  Output: 1

  Since the only special quadruplets found is $nums[0] + $nums[1] + $nums[2] ==
  $nums[3].

Example 2

  Input: @nums = (1,1,1,3,5)
  Output: 4

  $nums[0] + $nums[1] + $nums[2] == $nums[3]
  $nums[0] + $nums[1] + $nums[3] == $nums[4]
  $nums[0] + $nums[2] + $nums[3] == $nums[4]
  $nums[1] + $nums[2] + $nums[3] == $nums[4]

Example 3

  Input: @nums = (3,3,6,4,5)
  Output: 0

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first argument is negative, it must be preceded by "--" to distin-
   guish it from a command-line flag.
3. If $VERBOSE is set to True, the special quadruplets (if any) are appended to
   the output.

=end comment
#==============================================================================

use Test;

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 203, Task #1: Special Quadruplets (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 1 or more integers

    *@nums where { .elems >= 1 && .all ~~ Int:D }
)
#==============================================================================
{
    "Input:  \@nums = (%s)\n".printf: @nums.join: ',';

    my Array[Int] @quads = find-special-quadruplets( @nums );
    my UInt       $count = @quads.elems;

    "Output: $count".put;

    if $VERBOSE && $count > 0
    {
        put();
        "\$nums[%d] + \$nums[%d] + \$nums[%d] == \$nums[%d]\n".printf: @$_
            for @quads;
    }
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-special-quadruplets( List:D[Int:D] $nums --> List:D[Int:D] )
#------------------------------------------------------------------------------
{
    my Array[Int] @quads;

    for 0 .. $nums.end - 3 -> UInt $i
    {
        my Int $elem-a = $nums[ $i ];

        for $i + 1 .. $nums.end - 2 -> UInt $j
        {
            my Int $sum-ab = $elem-a + $nums[ $j ];

            for $j + 1 .. $nums.end - 1 -> UInt $k
            {
                my Int $sum = $sum-ab + $nums[ $k ];

                for $k + 1 .. $nums.end -> UInt $l
                {
                    @quads.push: Array[Int].new: $i, $j, $k, $l
                        if $sum == $nums[ $l ];
                }
            }
        }
    }

    return @quads;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) = $line.split: / \| /;

        my Int        @array = $input.split( / \, \s* / ).map: { .Int };
        my Array[Int] @quads = find-special-quadruplets( @array );

        is @quads.elems, $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|1,2,3,6  |1
        Example 2|1,1,1,3,5|4
        Example 3|3,3,6,4,5|0
        END
}

###############################################################################
