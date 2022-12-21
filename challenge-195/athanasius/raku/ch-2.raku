use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 195
=========================

TASK #2
-------
*Most Frequent Even*

Submitted by: Mohammad S Anwar

You are given a list of numbers, @list.

Write a script to find most frequent even numbers in the list. In case you get
more than one even numbers then return the smallest even integer. For all other
case, return -1.

Example 1

  Input: @list = (1,1,2,6,2)
  Output: 2 as there are only 2 even numbers 2 and 6 and of those 2 appears the
          most.

Example 2

  Input: @list = (1,3,5,7)
  Output: -1 since no even numbers found in the list

Example 3

  Input: @list = (6,4,4,6,1)
  Output: 4 since there are only two even numbers 4 and 6. They both appears
          the equal number of times, so pick the smallest.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Note
----
"In mathematics, parity is the property of an integer of whether it is even or
 odd. An integer is even if it is a multiple of two, and odd if it is not. For
 example, −4, 0, 82 are even..." -- "Parity (mathematics)", Wikipedia.

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 195, Task #2: Most Frequent Even (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@list where { .elems > 0 && .all ~~ Int:D }
)
#==============================================================================
{
    "Input:  \@list = (%s)\n".printf: @list.join: ', ';

    "Output: %d\n".printf: max-even-freq( @list );
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub max-even-freq( List:D[Int:D] $list --> Int:D )
#------------------------------------------------------------------------------
{
    my UInt %freq{Int};

    for @$list -> Int $n
    {
        ++%freq{ $n } if $n %% 2;
    }

    my Int  $solution = -1;
    my UInt $max-freq =  0;

    for %freq.kv -> Int $key, UInt $value
    {
        if    $value >  $max-freq
        {
            $solution = $key;
            $max-freq = $value;
        }
        elsif $value == $max-freq && $key < $solution
        {
            $solution = $key;
        }
    }

    return $solution;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS;

        my Int @list = $input.split( / \s+ /, :skip-empty ).map: { .Int };

        is max-even-freq( @list ), $expected.Int, $test-name;
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
        Example 1,  1  1  2  6  2,        2
        Example 2,  1  3  5  7,          -1
        Example 3,  6  4  4  6  1,        4
        Negatives, -2 -3 -2 -5 -4 -4 -2, -2
        END
}

###############################################################################
