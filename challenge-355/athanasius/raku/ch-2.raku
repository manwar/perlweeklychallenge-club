use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 355
=========================

TASK #2
-------
*Mountain Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return true if the given array is a valid mountain array.

  An array is mountain if and only if:
  1) arr.length >= 3
  and
  2) There exists some i with 0 < i < arr.length - 1 such that:
  arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
  arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

Example 1

  Input: @ints = (1, 2, 3, 4, 5)
  Output: false

Example 2

  Input: @ints = (0, 2, 4, 6, 4, 2, 0)
  Output: true

Example 3

  Input: @ints = (5, 4, 3, 2, 1)
  Output: false

Example 4

  Input: @ints = (1, 3, 5, 5, 4, 2)
  Output: false

Example 5

  Input: @ints = (1, 3, 2)
  Output: true

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 355, Task #2: Mountain Array (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Bool $is-mountain = is-mountain-array( @ints );

    "Output: %s\n".printf: $is-mountain ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub is-mountain-array( List:D[Int:D] $ints --> Bool:D )
#-------------------------------------------------------------------------------
{
    return False if $ints.elems < 3 || $ints[0] >= $ints[1];

    my Bool $going-up = True;
    my Int  $previous = $ints[1];

    for 2 .. $ints.end -> UInt $i
    {
        my Int $current = $ints[$i];

        return False if $current == $previous;

        if     $going-up && $current < $previous
        {
            $going-up = False;
        }
        elsif !$going-up && $current > $previous
        {
            return False;
        }

        $previous = $current;
    }

    return !$going-up;
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

        my Int @ints        = $ints-str.split( / \s+ /, :skip-empty )
                                       .map: { .Int };
        my Str $is-mountain = is-mountain-array( @ints ) ?? 'true' !! 'false';

        is $is-mountain, $expected, $test-name;
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
        Example 1|1 2 3 4 5    |false
        Example 2|0 2 4 6 4 2 0|true
        Example 3|5 4 3 2 1    |false
        Example 4|1 3 5 5 4 2  |false
        Example 5|1 3 2        |true
        END
}

################################################################################
