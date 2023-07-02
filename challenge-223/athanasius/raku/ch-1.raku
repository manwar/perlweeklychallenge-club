use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 223
=========================

TASK #1
-------
*Count Primes*

Submitted by: Mohammad S Anwar

You are given a positive integer, $n.

Write a script to find the total count of primes less than or equal to the given
integer.

Example 1

  Input: $n = 10
  Output: 4

  Since there are 4 primes (2,3,5,7) less than or equal to 10.

Example 2

  Input: $n = 1
  Output: 0

Example 3

  Input: $n = 20
  Output: 8

  Since there are 8 primes (2,3,5,7,11,13,17,19) less than or equal to 20.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Note
----
This is a repeat of Week 198, Task #2: "Prime Count", except that "less than $n"
has been changed to "less than or equal to" $n.

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 223, Task #1: Count Primes (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Pos:D $n                       #= A positive integer
)
#===============================================================================
{
    "Input:  \$n = $n".put;

    my UInt  $primes = count-primes( $n );

    "Output: $primes".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub count-primes( UInt:D $n where { $n > 0 } --> UInt:D )
#------------------------------------------------------------------------------
{
    my UInt $count  = 0;
    my Bool @sieve  = |(False xx 2), |(True xx ($n - 2));
    my UInt $sqrt-n = $n.sqrt.floor;

    for 2 .. $sqrt-n -> UInt $i
    {
        if @sieve[ $i ]
        {
            ++$count;

            for 0 .. * -> UInt $j
            {
                my UInt $k = $i² + $j * $i;

                last if $k >= $n;

                @sieve[ $k ] = False;
            }
        }
    }

    for $sqrt-n + 1 .. $n - 1 -> UInt $m
    {
        ++$count if @sieve[ $m ];
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $n, $expected) = $line.split: / \| /;

        for $test-name, $n, $expected                          # Trim whitespace
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $primes = count-primes( $n.Int );

        is $primes, $expected.Int, $test-name;
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
        Week 223, Example 1|     10|    4
        Week 223, Example 2|      1|    0
        Week 223, Example 3|     20|    8
        Week 198, Example 2|     15|    6
        Weel 198, Example 4|     25|    9
        Large n            |1000000|78498
        END
}

################################################################################
