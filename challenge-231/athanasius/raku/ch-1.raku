use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 231
=========================

TASK #1
-------
*Min Max*

Submitted by: Mohammad S Anwar

You are given an array of distinct integers.

Write a script to find all elements that is neither minimum nor maximum. Return
-1 if you can’t.

Example 1

  Input: @ints = (3, 2, 1, 4)
  Output: (3, 2)

  The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min
  nor max.

Example 2

  Input: @ints = (3, 1)
  Output: -1

Example 3

  Input: @ints = (2, 1, 3)
  Output: (2)

  The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor
  max.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
An output of "-1" denotes "no elements found", but an output of "(-1)" (note the
parentheses) means the element -1 was found. Hence, negative integers are allow-
ed in the input list.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first element in the input list is negative, it must be preceded by
   "--" to distinguish it from a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 231, Task #1: Min Max (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of distinct integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    are-distinct( @ints ) or error( 'Duplicate found in the input list' );

    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int @inner = find-inner( @ints );

    "Output: %s\n".printf: @inner.elems > 0 ?? '(' ~ @inner.join( ', ' ) ~ ')'
                                            !! '-1';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-inner( List:D[Int:D] $ints --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my Int $max = $ints.max;
    my Int $min = $ints.min;
    my Int @inner;

    for @$ints -> Int $int
    {
        @inner.push: $int if $min < $int < $max;
    }

    return @inner;
}

#-------------------------------------------------------------------------------
sub are-distinct( List:D[Int:D] $ints --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt %count{Int};
          ++%count{ $_ } for @$ints;

    return so 1 == %count.values.all;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $int-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints  = $int-str\ .split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @inner = find-inner( @ints );

        if $exp-str
        {
            my Int @exp = $exp-str.split( / \s+ /, :skip-empty ).map: { .Int };

            is-deeply @inner, @exp, $test-name;
        }
        else
        {
            is @inner.elems, 0, $test-name;
        }
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
        Example 1  | 3  2  1 4  | 3 2
        Example 2  | 3  1       |
        Example 3  | 2  1  3    | 2
        Negatives 1|-5 -1 -3 0 2|-1 -3 0
        Negatives 2|-2 -1  0    |-1
        END
}

################################################################################
