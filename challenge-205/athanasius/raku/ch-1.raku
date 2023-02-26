use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 205
=========================

TASK #1
-------
*Third Highest*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the Third Highest if found otherwise return the
maximum.

Example 1

  Input: @array = (5,3,4)
  Output: 3

  First highest is 5. Second highest is 4. Third highest is 3.

Example 2

  Input: @array = (5,6)
  Output: 6

  First highest is 6. Second highest is 5. Third highest is missing, so maximum
  is returned.

Example 3

  Input: @array = (5,4,4,3)
  Output: 3

  First highest is 5. Second highest is 4. Third highest is 3.

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

=end comment
#==============================================================================

use Test;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 205, Task #1: Third Highest (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 1 or more integers

    *@array where { .elems >= 1 && .all ~~ Int:D }
)
#==============================================================================
{
    "Input:  \@array = (%s)\n".printf: @array.join: ',';

    "Output: %d\n".printf: find-third-highest( @array );
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-third-highest( List:D[Int:D] $array where { .elems > 0 } --> Int:D )
#------------------------------------------------------------------------------
{
    my UInt %count{Int};

    ++%count{ $_ } for @$array;

    my Int @sorted = %count<>:k.sort;

    return @sorted.elems >= 3 ?? @sorted[ *-3 ] !! @sorted[ *-1 ];
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) = $line.split: / \| /;

        my Int @array = $input.split( / \, \s* / ).map: { .Int };
        my Int $got   = find-third-highest( @array );

        is $got, $expected.Int, $test-name;
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
        Example 1| 5, 3, 4      | 3
        Example 2| 5, 6         | 6
        Example 3| 5, 4, 4, 3   | 3
        Negatives|-1,-2,-3,-4,-2|-3
        END
}

###############################################################################
