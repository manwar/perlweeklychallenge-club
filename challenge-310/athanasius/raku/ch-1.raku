use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 310
=========================

TASK #1
-------
*Arrays Intersection*

Submitted by: Mohammad Sajid Anwar

You are given a list of array of integers.

Write a script to return the common elements in all the arrays.

Example 1

  Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
  Output: (1, 4)

Example 2

  Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
  Output: (2)

Example 3

  Input: $list = ( [1, 2, 3], [4, 5], [6] )
  Output: ()

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of strings is entered on the command-line. Each string is a list of
   integers, separated by whitespace.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 310, Task #1: Arrays Intersection (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@list                    #= A list of space-separated integer-array strings
)
#===============================================================================
{
    my Array[Int] @arrays = parse-input-list( @list );

    "Input:  \$list = ( %s )\n".printf:
        @arrays.map( { '[' ~ .join( ', ' ) ~ ']' } ).join: ', ';

    my Int @intersection = find-intersection( @arrays );

    "Output: (%s)\n".printf: @intersection.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-intersection( List:D[List:D[Int:D]] $list --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my UInt %int-count{Int};

    for @$list -> Int @ints
    {
        my UInt %local-count{Int};
              ++%local-count{ $_ } for @ints;

        ++%int-count{ $_ } for keys %local-count;
    }

    my Int @common =
           %int-count.keys.grep( { %int-count{ $_ } == $list.elems } ).sort;

    return @common;
}

#-------------------------------------------------------------------------------
sub parse-input-list( List:D[Str:D] $list --> List:D[List:D[Int:D]] )
#-------------------------------------------------------------------------------
{
    my Array[Int] @arrays;

    for @$list -> Str $array-str
    {
        my Int @array;
        my Str @elements = $array-str.split: / \s+ /, :skip-empty;

        for @elements
        {
            +$_ ~~ Int or error( qq["$_" is not a valid integer] );

            @array.push: +$_;
        }

        @arrays.push: @array;
    }

    return @arrays;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $list-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $list-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str        @list         = $list-str.split: / \; /,  :skip-empty;
        my Array[Int] @arrays       = parse-input-list( @list );
        my Int        @intersection = find-intersection( @arrays );
        my Int        @expected     = $exp-str\.split( / \s+ /, :skip-empty )\
                                               .map: { .Int };

        is-deeply @intersection, @expected, $test-name;
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
        Example 1|1 2 3 4; 4 5 6 1; 4 2 1 3|1 4
        Example 2|1 0 2 3; 2 4 5           |2
        Example 3|1 2 3;   4 5;     6      |
        END
}

################################################################################
