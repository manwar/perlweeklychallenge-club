use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 297
=========================

TASK #1
-------
*Contiguous Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of binary numbers, @binary.

Write a script to return the maximum length of a contiguous subarray with an
equal number of 0 and 1.

Example 1

  Input: @binary = (1, 0)
  Output: 2

  (1, 0) is the longest contiguous subarray with an equal number of 0 and 1.

Example 2

  Input: @binary = (0, 1, 0)
  Output: 2

  (1, 0) or (0, 1) is the longest contiguous subarray with an equal number of 0
  and 1.

Example 3

  Input: @binary = (0, 0, 0, 0, 0)
  Output: 0

Example 4

  Input: @binary = (0, 1, 0, 0, 1, 0)
  Output: 4

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
2. A non-empty list of binary digits is entered on the command-line; OR
3. A single string of two or more binary digits is entered on the command-line.

Algorithm
---------
Since the longest subarray contains an equal number of ones and zeros:
(a) it cannot be longer than 2n, where n is the smaller of the total numbers of
    ones and zeros in @binary; and
(b) it must be even in length.

Therefore, the search begins with t (the target subarray length) equal to 2n,
and proceeds with t = 2(n - 1), t = 2(n - 2), etc., down to t = 2.

For each value of t, subarrays of length t are searched in @binary from left
(index 0) to right. For example, if @binary is of length 11 and t = 5, the
search begins with @binary[ 0 .. 4 ] and continues with @binary[ 1 .. 5 ],
@binary[ 2 .. 6 ], etc, up to @binary[ 7 .. 11 ].

=end comment
#===============================================================================

use Test;

subset Bit of Int where 0 | 1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 297, Task #1: Contiguous Array (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of binary digits (0, 1)

    *@binary where { .elems > 0 && .all ~~ Bit:D }
)
#===============================================================================
{
    driver( @binary );
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty string of binary digits

    Str:D $bin-str where { .chars > 1 && / ^ <[ 0 1 ]>+ $ / };
)
#===============================================================================
{
    my Bit @binary = $bin-str.split( '', :skip-empty ).map: { .Int };

    driver( @binary );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub driver( List:D[Bit:D] $binary where { .elems > 0 } )
#-------------------------------------------------------------------------------
{
    "Input:  \@binary = (%s)\n".printf: $binary.join: ', ';

    my UInt  $max-len = solve( $binary );

    "Output: $max-len".put;
}

#-------------------------------------------------------------------------------
sub solve( List:D[Bit:D] $binary --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $size    = $binary.elems;
    my UInt $ones    = [+] @$binary;
    my UInt $zeros   = $size - $ones;
    my UInt $target  = 2 * ($ones, $zeros).min;

    loop (my UInt $t = $target; $t >= 2; $t -= 2)
    {
        for 0 .. $size - $t -> UInt $i
        {
            $ones = [+] @$binary[ $i .. $i + $t - 1 ];

            return $t if $ones * 2 == $t;
        }
    }

    return 0;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $bin-str, $expected) = $line.split: / \| /;

        for     $test-name, $bin-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Bit  @binary  = $bin-str.split( '', :skip-empty ).map: { .Int };
        my UInt $max-len = solve( @binary );

        is $max-len, $expected.Int, $test-name;
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
        Example 1|10    |2
        Example 2|010   |2
        Example 3|00000 |0
        Example 4|010010|4
        END
}

################################################################################
