use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 199
=========================

TASK #1
-------
*Good Pairs*

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find the total count of Good Pairs.


    A pair (i, j) is called good if list[i] == list[j] and i < j.


Example 1

  Input: @list = (1,2,3,1,1,3)
  Output: 4

  There are 4 good pairs found as below:
  (0,3)
  (0,4)
  (3,4)
  (2,5)

Example 2

  Input: @list = (1,2,3)
  Output: 0

Example 3

  Input: @list = (1,1,1,1)
  Output: 6

  Good pairs are below:
  (0,1)
  (0,2)
  (0,3)
  (1,2)
  (1,3)
  (2,3)

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
3. If $VERBOSE is set to True, an explanation like that in Examples 1 and 3 is
   appended to the solution.

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;
my Bool constant $VERBOSE     = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 199, Task #1: Good Pairs (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 1 or more integers

    *@list where { .elems >= 1 && .all ~~ Int:D }
)
#==============================================================================
{
    "Input:  \@list = (%s)\n".printf: @list.join: ',';

    my Array[UInt] @pairs = find-good-pairs( @list );

    "Output: %d\n".printf: @pairs.elems;

    give-details( @pairs ) if $VERBOSE;
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-good-pairs( List:D[Int:D] $list --> List:D[List:D[UInt:D]])
#------------------------------------------------------------------------------
{
    my Array[UInt] @pairs;

    for 0 .. $list.end - 1 -> UInt $i
    {
        for $i + 1 .. $list.end -> UInt $j
        {
            if $list[ $i ] == $list[ $j ]
            {
                @pairs.push: Array[UInt].new: $i, $j;
            }
        }
    }

    return @pairs;
}

#------------------------------------------------------------------------------
sub give-details( List:D[UInt:D] $pairs )
#------------------------------------------------------------------------------
{
    my UInt $count = $pairs.elems;

    if    $count == 0
    {
        "\nThere are no good pairs in the list".put;
    }
    elsif $count == 1
    {
        "\nThere is 1 good pair in the list:\n(%s)\n".printf:
            @$pairs[ 0 ].join: ',';
    }
    else
    {
        "\nThere are $count good pairs in the list:".put;

        ('(' ~ @$_.join( ',' ) ~ ')').put for @$pairs;
    }
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

        my Int         @list  = $input.split( / \, \s* / ).map: { .Int };
        my Array[UInt] @pairs = find-good-pairs( @list );
        my UInt        $got   = @pairs.elems;

        is $got, $expected, $test-name;
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
        Example 1| 1, 2, 3, 1, 1, 3|4
        Example 2| 1, 2, 3         |0
        Example 3| 1, 1, 1, 1      |6
        Negatives|-1,-2,-3,-1,-1,-3|4
        END
}

###############################################################################
