use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 212
=========================

TASK #2
-------
*Rearrange Groups*

Submitted by: Mohammad S Anwar

You are given a list of integers and group size greater than zero.

Write a script to split the list into equal groups of the given size where
integers are in sequential order. If it can’t be done then print -1.

Example 1:

  Input: @list = (1,2,3,5,1,2,7,6,3) and $size = 3
  Output: (1,2,3), (1,2,3), (5,6,7)

Example 2:

  Input: @list = (1,2,3) and $size = 2
  Output: -1

Example 3:

  Input: @list = (1,2,4,3,5,3) and $size = 3
  Output: (1,2,3), (3,4,5)

Example 4:

  Input: @list = (1,5,2,6,4,7) and $size = 3
  Output: -1

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
2. If the first element of @list is negative, it must be preceded by '--'.

Algorithm
---------
Given: M, a multiset of integers of size m = |M|; and
       s, an integer > 0.

Task:  Partition M into (m/s) groups, of equal size s, such that the elements of
       each group can be arranged in sequential order.

Solution:
(1) If s > m or s does not evenly divide m, output -1 as there is no solution.
    Otherwise:
(2) Remove the smallest element e from M and place it in the first group. Then
    remove an element f=e+1 from M and add it to group 1; and so on (element g=
          e+2, etc.) until the first group is filled (i.e., of size s).
(3) Repeat this process for the remaining groups, until M is empty.
(4) If at any point the required element is not found in M, immediately output
    -1 as there is no solution. Otherwise:
(5) Output all the groups constructed in (2) and (3). Since the order of the
    groups does not matter, this is the unique solution.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 211, Task #2: Rearrange Groups (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Pos:D :$size,                                          #= Size of each group
          *@list where { .elems > 0 && .all ~~ Int:D }     #= A list of integers
)
#===============================================================================
{
    my Int @int-list = @list.map: { .Int };           # Change IntStr's to Int's

    "Input:  \@list = (%s) and \$size = %d\n".printf:
        @int-list.join( ',' ), $size;

    my Array[Int] @groups = rearrange-groups( @int-list, $size );

    "Output: %s\n".printf:
        @groups ?? @groups.map( { '(' ~ .join( ',' ) ~ ')' } ).join( ', ' )
                !! '-1';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub rearrange-groups
(
    List:D[Int:D] $list where { .elems > 0 },
    Pos:D         $size,
--> List:D[List:D[Int:D]]
)
#-------------------------------------------------------------------------------
{
    my Array[Int] @groups;
    my Pos        $elements = $list.elems;

    if $size <= $elements && $elements %% $size
    {
        my UInt %ints{Int};
              ++%ints{ $_ } for @$list;

        while %ints         # OR:  for 1 .. ($elements / $size).Int
        {
            my Int @partition = my Int $smallest = %ints.keys.min;

            %ints{ $smallest }:delete if --%ints{ $smallest } == 0;

            for 1 .. $size - 1 -> UInt $inc
            {
                my Int $next = $smallest + $inc;

                return () unless %ints{ $next }:exists;

                @partition.push: $next;

                %ints{ $next }:delete if --%ints{ $next } == 0;
            }

            @groups.push: @partition;
        }
    }

    return @groups;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $list, $size, $output) = $line.split: / \| /;

        for $test-name, $list, $size             # Trim whitespace
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int        @ints   = $list.split( / \, \s* / ).map: { .Int };
        my Array[Int] @groups = rearrange-groups( @ints, $size.Int );
        my Array[Int] @expected;

        if $output ne '-1'
        {
            my Str @group-strs =
                  ($output ~~ m:g/ \,? \( .+? \) /).map: { .Str };

            for @group-strs                      # Trim whitespace
            {
                s/ ^ \,? \(   //;
                s/       \) $ //;

                @expected.push: Array[Int].new: .split( ',' ).map: { .Int };
            }
        }

        is-deeply @groups, @expected, $test-name;
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
        Example 1 | 1, 2, 3, 5, 1, 2,7,6,3|3|(1,2,3),(1,2,3),(5,6,7)
        Example 2 | 1, 2, 3               |2|-1
        Example 3 | 1, 2, 4, 3, 5, 3      |3|(1,2,3),(3,4,5)
        Example 4 | 1, 5, 2, 6, 4, 7      |3|-1
        Negatives |-7,-5,-6,-2,-3,-1      |3|(-7,-6,-5),(-3,-2,-1)
        Mixed     | 1,-8, 0,-9            |2|(-9,-8),(0,1)
        All in one| 6, 3, 5, 1, 4, 2      |6|(1,2,3,4,5,6)
        Singles   |-2, 3,-1,-1, 2, 7      |1|(-2),(-1),(-1),(2),(3),(7)
        END
}

################################################################################
