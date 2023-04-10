use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 211
=========================

TASK #2
-------
*Split Same Average*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out if the given can be split into two separate arrays
whose average are the same.

Example 1:

  Input: @nums = (1, 2, 3, 4, 5, 6, 7, 8)
  Output: true

  We can split the given array into (1, 4, 5, 8) and (2, 3, 6, 7).
  The average of the two arrays are the same i.e. 4.5.

Example 2:

  Input: @list = (1, 3)
  Output: false

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
2. If the first argument is negative, it must be preceded by "--".
3. If $VERBOSE is True, an output of "True" is followed by an explanation of how
   the array may be split (using the first solution found).

Notes
-----
1. Duplicates are allowed in the input array. Raku's built-in class Bag (for
   multisets) is a useful container.
2. Where more than one solution is possible, the preferred solution is one in
   which the partitions are closest in size.
3. The algorithm used is a simple search of all possible partitions formed from
   members of the input array; obviously, for larger arrays, this will not scale
   well.

=end comment
#===============================================================================

use Test;

my Bool constant $VERBOSE = True;

subset Solution of List where (Bool:D, Bag, Bag, Rat);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 211, Task #2: Split Same Average (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@nums where { .elems > 0 && .all ~~ Int:D }           #= A list of integers
)
#===============================================================================
{
    "Input:  \@nums = (%s)\n".printf: @nums.sort.join: ', ';

    my Solution $solution = split-same-avg( @nums );

    "Output: %s\n".printf: $solution[ 0 ] ?? 'True' !! 'False';

    if $VERBOSE && $solution[ 0 ]
    {
        "\nWe can split the given array into (%s) and (%s)\n".printf:
            $solution[ 1 ].keys.sort.join( ', ' ),
            $solution[ 2 ].keys.sort.join( ', ' );

        "The average of each of these arrays is { $solution[ 3 ] }".put;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub split-same-avg( List:D[Int:D] $nums --> Solution:D )
#-------------------------------------------------------------------------------
{
    if $nums.elems >= 2
    {
        my Bag[Int] $univ = Bag[Int].new: $nums.map: { .Int };

        # Prefer the solution in which the partitions are closest in size (see
        # Notes 2 above)

        for $nums.combinations: (1 .. ($nums.elems / 2).floor).reverse
        {
            my Int      @comb  = .map: { .Int };
            my Bag[Int] $part1 =  Bag[Int].new: @comb;
            my Bag[Int] $part2 =  $univ (-) $part1;
            my Rat      $avg1  = ([+] $part1.keys) / $part1.elems;
            my Rat      $avg2  = ([+] $part2.keys) / $part2.elems;

            return [True, $part1, $part2, $avg1] if $avg1 == $avg2;
        }
    }

    return [False, Bag, Bag, Rat];
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, @output) = $line.split: / \| /;

        $test-name   ~~ s/ \s+ $ //;          # Trim whitespace
        $input       ~~ s/ \s+ $ //;
        @output[ 0 ] ~~ s/ \s+ $ //;

        my Int      @nums     = $input\.split( / \, \s* / ).map: { .Int };
        my Bool     $expected = @output[ 0 ] eq 'True' ?? True !! False;
        my Solution $got      = split-same-avg( @nums );

        is $got[ 0 ], $expected, $test-name;

        if $got[ 0 ] && $expected
        {
            my Bag[Int] $part1 = Bag[Int].new:
                                 @output[ 1 ].split( / \, \s* / ).map: { .Int };
            my Bag[Int] $part2 = Bag[Int].new:
                                 @output[ 2 ].split( / \, \s* / ).map: { .Int };
            my Rat      $avg   = @output[ 3 ].Rat;

            ok $got[ 1 ] ≡ $part1, "$test-name: partition 1";
            ok $got[ 2 ] ≡ $part2, "$test-name: partition 2";
            is $got[ 3 ],  $avg,   "$test-name: average";
        }
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
    # The specific solution to Example 1 has been changed in accordance with the
    # algorithm used in split-same-avg()

    return q:to/END/;
        Example 1| 1, 2, 3, 4, 5, 6, 7, 8|True | 1, 2, 7, 8| 3, 4, 5, 6| 4.5
        Example 2| 1, 3                  |False
        Negatives|-4,-2,-3               |True |-3         |-4,-2      |-3
        Mixed 1  |-7, 5, 0, 9,12,-1, 4, 6|True |-7, 4, 5,12|-1, 0, 6, 9| 3.5
        Mixed 2  |-7, 5, 0, 9,12,-1, 4, 5|False
        Same     | 4, 4                  |True | 4         | 4         | 4
        Zeros    | 0, 0, 0               |True | 0         | 0, 0      | 0
        One      |42                     |False
        END
}

################################################################################
