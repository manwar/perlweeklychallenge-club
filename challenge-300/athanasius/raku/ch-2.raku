use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 300
=========================

TASK #2
-------
*Nested Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints of length n containing permutation of
the numbers in the range [0, n - 1].

Write a script to build a set, set[i] = ints[i], ints[ints[i]],
ints[ints[ints[i]]], ..., subjected to the following rules:

  1. The first element in set[i] starts with the selection of elements ints[i].
  2. The next  element in set[i] should be ints[ints[i]], and then
     ints[ints[ints[i]]], and so on.
  3. We stop adding right before a duplicate element occurs in set[i].

Return the longest length of a set set[i].

Example 1

  Input: @ints = (5, 4, 0, 3, 1, 6, 2)
  Output: 4

  ints[0] = 5
  ints[1] = 4
  ints[2] = 0
  ints[3] = 3
  ints[4] = 1
  ints[5] = 6
  ints[6] = 2

  One of the longest sets set[k]:
  set[0] = {ints[0], ints[5], ints[6], ints[2]} = {5, 6, 2, 0}

Example 2

  Input: @ints = (0, 1, 2)
  Output: 1

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The given integers are valid array indices, and therefore unsigned.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line. This
   list, of length n, must be a permutation of the numbers in the range 0 to
   n - 1.
3. If the constant VERBOSE is set to True, the contents of the longest set are
   appended to the required output of longest set length.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 300, Task #2: Nested Array (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| List of n integers constituting a permutation of 0 .. n - 1

    *@ints where { .elems > 0 && .all ~~ UInt:D && is-permutation( @ints ) }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt @longest-set = find-longest-set( @ints );

    "Output: %d\n".printf: @longest-set.elems;

    "\nFirst solution: \{%s\}\n".printf: @longest-set.join: ', ' if VERBOSE;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-longest-set
(
    List:D[UInt:D] $ints where { .elems > 0 && is-permutation( $ints ) }
--> List:D[UInt:D]
)
#-------------------------------------------------------------------------------
{
    my UInt @longest-set;

    for 0 .. $ints.end -> UInt $i
    {
        my UInt @set = $ints[ $i ];

        loop
        {
            my UInt $next = $ints[ @set[ *-1 ] ];

            if $next ∈ @set
            {
                @longest-set = @set if @set.elems > @longest-set.elems;
                last;
            }

            @set.push: $next;
        }
    }

    return @longest-set;
}

#-------------------------------------------------------------------------------
sub is-permutation( List:D[UInt:D] $ints --> Bool:D )
#-------------------------------------------------------------------------------
{
    return False unless $ints.min == 0;
    return False unless $ints.max == $ints.elems - 1;

    my UInt %count{UInt};

    for @$ints -> UInt $int
    {
        return False if ++%count{ $int } > 1;
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected) = $line.split: / \| /;

        for     $test-name, $ints-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @set  = find-longest-set( @ints );

        is @set.elems, $expected.Int, $test-name;
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
        Example 1|5 4 0 3 1 6 2|4
        Example 2|0 1 2        |1
        END
}

################################################################################
