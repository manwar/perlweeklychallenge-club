use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 283
=========================

TASK #1
-------
*Unique Number*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, where every elements appears more
than once except one element.

Write a script to find the one element that appears exactly one time.

Example 1

  Input: @ints = (3, 3, 1)
  Output: 1

Example 2

  Input: @ints = (3, 2, 4, 2, 4)
  Output: 3

Example 3

  Input: @ints = (1)
  Output: 1

Example 4

  Input: @ints = (4, 3, 1, 1, 1, 4)
  Output: 3

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 283, Task #1: Unique Number (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| List of integers in which exactly 1 int appears exactly once

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    my Int @ints_ = @ints;             # Make a copy, then
           @ints_.map: { $_ += 0 };    # Normalize the elements (e.g., -0 --> 0)

    "Input:  \@ints = (%s)\n".printf: @ints_.join: ', ';

    my Int $unique-num = find-unique-num( @ints_ );

    if $unique-num.defined
    {
        "Output: $unique-num".put;
    }
    else
    {
        put();
        error( 'The input list is invalid' );
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-unique-num( List:D[Int:D] $ints --> Int:_ )
#-------------------------------------------------------------------------------
{
    my UInt %count{Int};

    ++%count{ $_ } for @$ints;

    my Int @singletons = %count.keys.grep: { %count{ $_ } == 1 };

    return @singletons.elems == 1 ?? @singletons[ 0 ] !! Nil;
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

        my Int @ints       = $ints-str.split( / \s+ / ).map: { .Int };
        my Int $unique-num = find-unique-num( @ints );

        $unique-num.defined or die( 'Invalid test data' );

        is $unique-num, $expected.Int, $test-name;
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
        Example 1|3 3 1      |1
        Example 2|3 2 4 2 4  |3
        Example 3|1          |1
        Example 4|4 3 1 1 1 4|3
        END
}

################################################################################
