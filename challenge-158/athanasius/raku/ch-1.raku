use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 158
=========================

TASK #1
-------
*Additive Primes*

Submitted by: Mohammad S Anwar

Write a script to find out all Additive Primes <= 100.

    Additive primes are prime numbers for which the sum of their decimal digits
    are also primes.

Output

 2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
1. Generate primes in the required range using the Sieve of Eratosthenes [3]
2. For each prime in the sieve:
    - sum the digits
    - if the sum is a prime number recorded in the sieve, add it to the list of
      additive primes
3. Output the list of additive primes

References
----------
[1] "A046704  Additive primes: sum of digits is a prime.", OEIS,
     https://oeis.org/A046704
[2]  Reinhard Zumkeller, "Table of n, a(n) for n = 1..10000", OEIS,
     https://oeis.org/A046704/b046704.txt
[3] "Sieve of Eratosthenes", Wikipedia,
     https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

=end comment
#==============================================================================

my UInt constant $MAX = 100;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 158, Task #1: Additive Primes (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
                                                              # Sieve:
    my Bool @is-prime = False, False, |(True xx ($MAX - 1));  # 0, 1, (2..$MAX)

    for 0 .. $MAX -> UInt $n                                  # Find the primes
    {
        next unless @is-prime[ $n ];                          # Skip non-primes

        loop (my UInt $i = 2 * $n; $i <= $MAX; $i += $n)
        {
            @is-prime[ $i ] = False;
        }
    }

    my UInt @additive-primes;

    for 0 .. $MAX -> UInt $p
    {
        next unless @is-prime[ $p ];                          # Skip non-primes

        my UInt $sum = [+] $p.split: '', :skip-empty;         # Sum the digits

        @additive-primes.push: $p if @is-prime[ $sum ];
    }

    "Additive primes <= %d:\n\n %s\n".printf:
        $MAX, @additive-primes.join: ', ';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
