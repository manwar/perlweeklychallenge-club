use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 188
=========================

TASK #1
-------
*Divisible Pairs*

Submitted by: Mohammad S Anwar

You are given list of integers @list of size $n and divisor $k.

Write a script to find out count of pairs in the given list that satisfies the
following rules.

  The pair (i, j) is eligible if and only if
  a) 0 <= i < j < len(list)
  b) list[i] + list[j] is divisible by k

Example 1

  Input: @list = (4, 5, 1, 6), $k = 2
  Output: 2

Example 2

  Input: @list = (1, 2, 3, 4), $k = 2
  Output: 2

Example 3

  Input: @list = (1, 3, 4, 5), $k = 3
  Output: 2

Example 4

  Input: @list = (5, 1, 2, 3), $k = 4
  Output: 2

Example 5

  Input: @list = (7, 2, 4, 5), $k = 4
  Output: 1

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
- If no arguments are given on the command line, the test suite is run.
- If one or more arguments are given, the first is taken to be the divisor $k,
  and the remainder (if any) are taken to be the elements of @list.
- If $VERBOSE is set to True, the output count of pairs is followed by a list-
  ing of the pairs themselves.

Note
----
Each (i, j) is a pair of *indices* into the given list.

=end comment
#==============================================================================

use Test;

subset Result of List where (UInt, Array[Array[Int]]);

my UInt constant $TEST-FIELDS = 4;
my Bool constant $VERBOSE     = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 188, Task #1: Divisible Pairs (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    Int:D $k    where {  $k  != 0     },        #= A non-zero integer divisor
         *@list where { .all ~~ Int:D }         #= A list of 0 or more integers
)
#==============================================================================
{
    "Input:  @list = (%s), \$k = %d\n".printf:
        @list.map( { +$_ } ).join( ', ' ), $k;

    my (UInt $count, Array[Array[Int]] $pairs) =
        count-divisible-pairs( @list, $k );

    if $VERBOSE
    {
        "Output: %d (%s)\n".printf:
            $count, $pairs.map( { '[' ~ .join( ', ' ) ~ ']' } ).join: ', ';
    }
    else
    {
        "Output: $count".put;
    }
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub count-divisible-pairs
(
    List:D[Int:D] $list,
    Int:D         $k where { $k != 0 }
--> Result:D
)
#------------------------------------------------------------------------------
{
    my UInt $n     = $list.elems;
    my UInt $count = 0;
    my Array[Int] @pairs;

    for 0 .. $n - 1 -> UInt $i
    {
        for $i + 1 .. $n - 1 -> UInt $j
        {
            if ($list[ $i ] + $list[ $j ]) %% $k
            {
                ++$count;
                @pairs.push: Array[Int].new( $i, $j ) if $VERBOSE;
            }
        }
    }

    return $count, @pairs;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $list, $k, $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS;

        my Int @data = $list.split( / \s+ / ).map: { .Int };

        my (UInt $count, Any) = count-divisible-pairs( @data, +$k );

        is $count, $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1,  4 5 1 6, 2, 2
        Example 2,  1 2 3 4, 2, 2
        Example 3,  1 3 4 5, 3, 2
        Example 4,  5 1 2 3, 4, 2
        Example 5,  7 2 4 5, 4, 1
        Empty list,        , 1, 0
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
