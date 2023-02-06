use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 202
=========================

TASK #1
-------
*Consecutive Odds*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to print 1 if there are THREE consecutive odds in the given
array otherwise print 0.

Example 1

  Input: @array = (1,5,3,6)
  Output: 1

Example 2

  Input: @array = (2,6,3,5)
  Output: 0

Example 3

  Input: @array = (1,2,3,4)
  Output: 0

Example 4

  Input: @array = (2,3,5,7)
  Output: 1

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

Assumption
----------
Where the Task description says "if there are THREE consecutive odds in the
given array", it means "if there are AT LEAST THREE consecutive odds in the
given array".

=end comment
#==============================================================================

use Test;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 202, Task #1: Consecutive Odds (Raku)\n".put;
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

    "Output: %d\n".printf: three-consecutive-odds( @array ) ?? 1 !! 0;
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub three-consecutive-odds( List:D[Int:D] $array --> Bool:D )
#------------------------------------------------------------------------------
{
    my Bool $found = False;
    my UInt $count = 0;                 # Count of consecutive odd numbers

    for @$array -> Int $n
    {
        if $n %% 2                      # Even
        {
            $count = 0;                 # Reset the count
        }
        elsif ++$count == 3             # Odd and 3 consecutive odds found
        {
            $found = True;
            last;
        }
    }

    return $found;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) = $line.split: / \| /;

        my Int  @array = $input.split( / \, \s* / ).map: { .Int };
        my UInt $got   = three-consecutive-odds( @array ) ?? 1 !! 0;

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
        Example 1|1,5,3,6|1
        Example 2|2,6,3,5|0
        Example 3|1,2,3,4|0
        Example 4|2,3,5,7|1
        END
}

###############################################################################
