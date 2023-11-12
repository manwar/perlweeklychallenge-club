use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 242
=========================

TASK #1
-------
*Missing Members*

Submitted by: Mohammad S Anwar

You are given two arrays of integers.

Write a script to find out the missing members in each other arrays.

Example 1

  Input: @arr1 = (1, 2, 3)
         @arr2 = (2, 4, 6)
  Output: ([1, 3], [4, 6])

  (1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
  (2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).

Example 2

  Input: @arr1 = (1, 2, 3, 3)
         @arr2 = (1, 1, 2, 2)
  Output: ([3])

  (1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since
  they are same, keep just one.
  (1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).

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

my Str constant SEPARATOR = '*';

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 242, Task #1: Missing Members (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems >= 1 }      #= Two lists of integers, separated by "*"
)
#===============================================================================
{
    my Array[Int] ($arr1, $arr2) = parse-command-line( @ints );

    "Input:  \@arr1 = (%s)\n".printf: $arr1.join: ', ';
    "        \@arr2 = (%s)\n".printf: $arr2.join: ', ';

    my Array[Int] ($out1, $out2) = find-missing-members( $arr1, $arr2 );

    "Output: ([%s], [%s])\n".printf:  $out1.join( ', ' ),
                                      $out2.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-missing-members
(
    List:D[Int:D] $arr1,
    List:D[Int:D] $arr2,
--> List:D[List:D[Int:D], List:D[Int:D]]
)
#-------------------------------------------------------------------------------
{
    my Set[Int] $set1  = Set[Int].new: |$arr1;
    my Set[Int] $set2  = Set[Int].new: |$arr2;
    my Set[Int] $inter = $set1  ∩  $set2;           # Intersection
    my Set[Int] $out1  = $set1 (-) $inter;          # Set difference
    my Set[Int] $out2  = $set2 (-) $inter;          # Set difference
    my Int      @out1  = $out1.keys.sort;
    my Int      @out2  = $out2.keys.sort;

    return @out1, @out2;
}

#-------------------------------------------------------------------------------
sub parse-command-line
(
    List:D[Str:D] $ints where { .elems >= 1 }
--> List:D[List:D[Int:D], List:D[Int:D]]
)
#-------------------------------------------------------------------------------
{
    $ints.none eq SEPARATOR
        and error( 'No separator character found' );

    $ints.one  eq SEPARATOR
        or  error( 'More than one separator character found' );

    my UInt $pivot;

    for 0 .. $ints.end -> UInt $i
    {
        if $ints[ $i ] eq SEPARATOR
        {
            $pivot = $i;
            last;
        }
    }

    my Str @arr1 = $ints[ 0       ..^ $pivot    ];
    my Str @arr2 = $ints[ $pivot ^..  $ints.end ];

    @arr1.all ~~ Int:D
        or  error( 'An element in the first list is not a valid integer'  );

    @arr2.all ~~ Int:D
        or  error( 'An element in the second list is not a valid integer' );

    return Array[Int].new( @arr1 ), Array[Int].new( @arr2 );
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $arr1-str, $arr2-str, $exp1-str, $exp2-str) =
                $line.split: / \| /;

        for     $test-name, $arr1-str, $arr2-str, $exp1-str, $exp2-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @arr1 = $arr1-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @arr2 = $arr2-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @exp1 = $exp1-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @exp2 = $exp2-str.split( / \s+ /, :skip-empty ).map: { .Int };

        my Array[Int] ($out1, $out2) = find-missing-members( @arr1, @arr2 );

        is-deeply $out1, @exp1, $test-name ~ ': array 1';
        is-deeply $out2, @exp2, $test-name ~ ': array 2';
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
        Example 1 | 1 2 3   | 2  4 6  | 1 3| 4 6
        Example 2 | 1 2 3  3| 1  1 2 2| 3  |
        Example 2a| 1 1 2  2| 1  2 3 3|    | 3
        Negatives |-3 5 7 -1|-1 -2 0 5|-3 7|-2 0
        END
}

################################################################################
