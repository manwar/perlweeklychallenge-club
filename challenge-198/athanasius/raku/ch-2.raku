use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 198
=========================

TASK #2
-------
*Prime Count*

Submitted by: Mohammad S Anwar

You are given an integer $n > 0.

Write a script to print the count of primes less than $n.

Example 1

  Input: $n = 10
  Output: 4 as in there are 4 primes less than 10 are 2, 3, 5, 7.

Example 2

  Input: $n = 15
  Output: 6

Example 3

  Input: $n = 1
  Output: 0

Example 4

  Input: $n = 25
  Output: 9

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Algorithm
---------
Neither Inline::Perl5 (for Math::Prime::Util/ntheory) nor Math::Primesieve will
(currently) install on my Rakudo platform. I have therefore implemented a Sieve
of Eratosthenes [1] to generate primes up to the given n.

This performs well for small values of n, but is quite slow for larger values:
e.g., for n = one million, the sieve takes about 24 seconds. By comparison, the
ntheory::prime_count() function takes about 0.005 seconds for the same n.

Reference
---------
[1] "Sieve of Eratosthenes", Wikipedia, 
    https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 198, Task #2: Prime Count (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    UInt:D $n where { $n > 0 }                  #= An integer greater than zero
)
#==============================================================================
{
    "Input:  \$n = $n".put;

    "Output: %d\n".printf: count-primes( $n );
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
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

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $n, $expected) = $line.split: / \| /, $TEST-FIELDS;

        s/ ^ \s* (.+?) \s* $ /$0/                             # Trim whitespace
            for $test-name, $n, $expected;

        is count-primes( $n.Int ), $expected.Int, $test-name;
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
        Example 1|     10|    4
        Example 2|     15|    6
        Example 3|      1|    0
        Example 4|     25|    9
        Large n  |1000000|78498
        END
}

###############################################################################
