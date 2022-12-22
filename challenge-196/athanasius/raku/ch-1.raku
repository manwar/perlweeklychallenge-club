use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 196
=========================

TASK #1
-------
*Pattern 132*

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find out subsequence that respect Pattern 132. Return empty
array if none found.

    Pattern 132 in a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] <
    a[k] < a[j].

Example 1

  Input:  @list = (3, 1, 4, 2)
  Output: (1, 4, 2) respect the Pattern 132.

Example 2

  Input: @list = (1, 2, 3, 4)
  Output: () since no susbsequence can be found.

Example 3

  Input: @list = (1, 3, 2, 4, 6, 5)
  Output: (1, 3, 2) if more than one subsequence found then return the first.

Example 4

  Input: @list = (1, 3, 4, 2)
  Output: (1, 3, 2)

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. If the first argument is negative, it must be preceded by "--" to distin-
   guish it from a command-line flag.

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 196, Task #1: Pattern 132 (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 3 or more integers

    *@list where { .elems >= 3 && .all ~~ Int:D }
)
#==============================================================================
{
    "Input:  \@list = (%s)\n".printf:              @list\ .join: ', ';

    "Output: (%s)\n"\        .printf: pattern_132( @list ).join: ', ';
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub pattern_132( List:D[Int:D] $list --> List:D[Int:D] )
#------------------------------------------------------------------------------
{
    my Int @pattern;

    L-OUTER:
    for 0 .. $list.end - 2 -> UInt $i
    {
        for $i + 1 .. $list.end - 1 -> UInt $j
        {
            next unless $list[ $i ] < $list[ $j ];

            for $j + 1 .. $list.end -> UInt $k
            {
                if $list[ $i ] < $list[ $k ] < $list[ $j ]
                {
                    @pattern = $list[ $i, $j, $k ];
                    last L-OUTER;
                }
            }
        }
    }

    return @pattern;
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

        $input    ~~ s/ ^ \s* (.+) \s* $ /$0/;                # Trim whitespace
        $expected ~~ s/ ^ \s* (.+) \s* $ /$0/;

        my Int @list = $input.split( / \s+ / ).map: { .Int };
        my Str $got  = pattern_132( @list ).join: ', ';

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
        Example 1| 3  1 4 2    | 1, 4, 2
        Example 2| 1  2 3 4    |
        Example 3| 1  3 2 4 6 5| 1, 3, 2
        Example 4| 1  3 4 2    | 1, 3, 2
        Negatives|-1 -2 1 0    |-1, 1, 0
        END
}

###############################################################################
