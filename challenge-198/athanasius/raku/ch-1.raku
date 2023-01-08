use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 198
=========================

TASK #1
-------
*Max Gap*

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find the total pairs in the sorted list where 2 consecutive
elements has the max gap. If the list contains less then 2 elements then return
0.

Example 1

  Input:  @list = (2,5,8,1)
  Output: 2

  Since the sorted list (1,2,5,8) has 2 such pairs (2,5) and (5,8)

Example 2

  Input: @list = (3)
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
1. If no command-line arguments are given, the test suite is run.
2. If the first argument is negative, it must be preceded by "--" to distin-
   guish it from a command-line flag.
3. If $VERBOSE is set to True, an explanation like that in Example 1 is added
   to the solution.

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;
my Bool constant $VERBOSE     = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 198, Task #1: Max Gap (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 1 or more integers

    *@list where { .elems >= 1 && .all ~~ Int:D }
)
#==============================================================================
{
    "Input:  \@list = (%s)\n".printf: @list.join: ', ';

    my (UInt $max-pairs, Int $max-gap, Array[Array[Int]] $pairs) =
        max-gap( @list );

    "Output: $max-pairs".put;

    if $VERBOSE && @list.elems > 1
    {
        ("\nSince the sorted list (%s) has %d pair%s with the maximum gap " ~
         "of %d:\n%s\n").printf:
                @list.sort.join( ',' ),
                $max-pairs,
               ($max-pairs == 1 ?? '' !! 's'),
                $max-gap,
                @$pairs.map( { '(' ~ @$_.join( ',' ) ~ ')' } ).join: ', ';
    }
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub max-gap
(
    List:D[Int:D] $list
--> List:D[UInt:D, Int:D, List:D[List:D[Int:D]]]
)
#------------------------------------------------------------------------------
{
    my Int        @sorted    = $list.sort;
    my Int        $max-gap   = -1;
    my UInt       $max-pairs =  0;
    my Array[Int] @pairs;

    for 0 .. @sorted.end - 1 -> UInt $i
    {
        my UInt $gap = @sorted[ $i + 1 ] - @sorted[ $i ];

        if    $gap >  $max-gap
        {
            $max-gap   = $gap;
            $max-pairs = 1;
            @pairs     = Empty;
            @pairs.push: Array[Int].new: @sorted[ $i, $i + 1 ];
        }
        elsif $gap == $max-gap
        {
            ++$max-pairs;
            @pairs.push: Array[Int].new: @sorted[ $i, $i + 1 ];
        }
    }    

    return $max-pairs, $max-gap, @pairs;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) =
                $line.split: / \| /, $TEST-FIELDS;

        $input    ~~ s/ ^ \s* (.+?) \s* $ /$0/;               # Trim whitespace
        $expected ~~ s/ ^ \s* (.+?) \s* $ /$0/;
        $expected ~~ s:g/ \s+ / /;

        my Int @list = $input.split( / \, \s* / ).map: { .Int };

        my (UInt $max-pairs, $, $) = max-gap( @list );

        my  Str $got = $max-pairs.join: ', ';

        is $got, $expected, $test-name;
    }

    done-testing;
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

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1| 2,  5,  8,  1   |2
        Example 2| 3               |0
        Negatives|-5, -1, -3       |2
        Mixed    |-3,  4,  2, -1, 1|3
        END
}

###############################################################################
