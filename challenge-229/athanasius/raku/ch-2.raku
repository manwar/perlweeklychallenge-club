use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 229
=========================

TASK #2
-------
*Two out of Three*

Submitted by: Mohammad S Anwar

You are given three array of integers.

Write a script to return all the elements that are present in at least 2 out of
3 given arrays.

Example 1

  Input: @array1 = (1, 1, 2, 4)
         @array2 = (2, 4)
         @array3 = (4)
  Output: (2, 4)

Example 2

  Input: @array1 = (4, 1)
         @array2 = (2, 4)
         @array3 = (1, 2)
  Output: (1, 2, 4)

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
2. If the first element of the first array is negative, it must be preceded by
   "--" to indicate that it is not a command-line switch.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 229, Task #2: Two out of Three (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $array1,           #= A string of comma-separated integers
    Str:D $array2,           #= A string of comma-separated integers
    Str:D $array3            #= A string of comma-separated integers
)
#===============================================================================
{
    my Int @array1 = parse-int-str( $array1 );
    my Int @array2 = parse-int-str( $array2 );
    my Int @array3 = parse-int-str( $array3 );

    "Input:  \@array1 = (%s)\n".printf: @array1.join: ', ';
    "        \@array2 = (%s)\n".printf: @array2.join: ', ';
    "        \@array3 = (%s)\n".printf: @array3.join: ', ';

    my Int @shared = find-shared-elements( @array1, @array2, @array3 );

    "Output: (%s)\n".printf: @shared.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-shared-elements
(
    List:D[Int:D] $array1,
    List:D[Int:D] $array2,
    List:D[Int:D] $array3
--> List:D[Int:D]
)
#-------------------------------------------------------------------------------
{
    my Int  @shared;
    my UInt %count{Int};

    ++%count{ $_ } for |$array1.unique, |$array2.unique, |$array3.unique;

    for %count.keys -> Int $key
    {
        @shared.push: $key if %count{ $key } >= 2;
    }

    @shared .= sort;

    return @shared;
}

#-------------------------------------------------------------------------------
sub parse-int-str( Str:D $str --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my Str @elements = $str.split: / \s* \, \s* /, :skip-empty;
    my Int @ints;

    for @elements -> Str $element
    {
        if val( $element ) ~~ Int:D
        {
            @ints.push: $element.Int;
        }
        else
        {
            error( qq["$element" is not a valid integer] );
        }
    }

    return @ints;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $arry1-str, $arry2-str, $arry3-str, $exptd-str) =
                $line.split: / \| /;

        for     $test-name, $arry1-str, $arry2-str, $arry3-str, $exptd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @array1 = $arry1-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @array2 = $arry2-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @array3 = $arry3-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @expctd = $exptd-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @shared = find-shared-elements( @array1, @array2, @array3 );

        is-deeply @shared, @expctd, $test-name;
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
        Example 1| 1 1 2 4   | 2   4        |4      | 2 4
        Example 2| 4 1       | 2   4        |1  2   | 1 2 4
        Negatives|-1 7 0 5 12|-5 -12 -1 17 4|0 32   |-1 0
        Disjoint | 1 2 3 4   |-1  -2 -3 -4  |0  5 -5|
        END
}

################################################################################
