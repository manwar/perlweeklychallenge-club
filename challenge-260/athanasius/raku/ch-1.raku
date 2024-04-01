use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 260
=========================

TASK #1
-------
*Unique Occurrences*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return 1 if the number of occurrences of each value in the
given array is unique or 0 otherwise.

Example 1

  Input: @ints = (1,2,2,1,1,3)
  Output: 1

  The number 1 occurred 3 times.
  The number 2 occurred 2 times.
  The number 3 occurred 1 time.

  All occurrences are unique, therefore the output is 1.

Example 2

  Input: @ints = (1,2,3)
  Output: 0

Example 3

  Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)
  Output: 1

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
2. One or more integers are given as arguments on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 259, Task #1: Unique Occurrences (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ',';

    my Bool $unique = unique-occurrences( @ints );

    "Output: %d\n".printf: $unique ?? 1 !! 0;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub unique-occurrences( List:D[Int:D] $ints --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt %dict;
          ++%dict{ $_ } for @$ints;

    my UInt @occurrences = %dict.values;
    my UInt @unique-occs = @occurrences.unique;

    return  @occurrences.elems == @unique-occs.elems;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @ints     = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Bool $unique   = unique-occurrences( @ints );
        my Bool $expected = $expected-str eq '1';

        is $unique, $expected, $test-name;
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
        Example 1| 1 2 2  1 1 3         |1
        Example 2| 1 2 3                |0
        Example 3|-2 0 1 -2 1 1 0 1 -2 9|1
        END
}

################################################################################
