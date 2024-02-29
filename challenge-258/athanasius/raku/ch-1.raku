use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 258
=========================

TASK #1
-------
*Count Even Digits Number*

Submitted by: Mohammad Sajid Anwar

You are given a array of positive integers, @ints.

Write a script to find out how many integers have even number of digits.

Example 1

  Input: @ints = (10, 1, 111, 24, 1000)
  Output: 3

  There are 3 integers having even digits i.e. 10, 24 and 1000.

Example 2

  Input: @ints = (111, 1, 11111)
  Output: 0

Example 3

  Input: @ints = (2, 8, 1024, 256)
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
"Positive" integers are greater than or equal to zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If VERBOSE is set to True, the required output is followed by a list of the
   even-digit numbers found.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 258, Task #1: Count Even Digits Number (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of positive integers

    *@ints where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt @evens = find-even-digit-numbers( @ints );

    "Output: %d\n".printf: @evens.elems;

    if VERBOSE
    {
        "\nEven-digit integers: %s\n".printf: @evens.sort.join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-even-digit-numbers( List:D[UInt:D] $ints --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @evens;

    for @$ints -> UInt $i
    {
        @evens.push: $i if $i.chars %% 2;
    }

    return @evens;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $expected) = $line.split: / \| /;

        for     $test-name, $int-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @ints  = ($int-str.split: / \s+ /, :skip-empty).map: { .Int };
        my UInt @evens =  find-even-digit-numbers( @ints );

        is @evens.elems, $expected.Int, $test-name;
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
        Example 1| 10 1   111  24 1000|3
        Example 2|111 1 11111         |0
        Example 3|  2 8  1024 256     |1
        END
}

################################################################################
