use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 159
=========================

TASK #2
-------
*Moebius Number*

Submitted by: Mohammad S Anwar

You are given a positive number $n.

Write a script to generate the Moebius Number for the given number. Please
refer to wikipedia [ https://en.wikipedia.org/wiki/M%C3%B6bius_function |page]
for more informations.

Example 1:

  Input: $n = 5
  Output: -1

Example 2:

  Input: $n = 10
  Output: 1

Example 3:

  Input: $n = 20
  Output: 0

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
When the constant $VERBOSE is set to True (the default), the output is followed
by an explanation, e.g.:

        17:00 >raku ch-2.raku 5

        Challenge 159, Task #2: Moebius Number (Raku)

        Input:  $n = 5
        Output: -1

        Explanation: 5 has prime factor 5^1,
                     so mu(5) = -1 because 5 is square-free
                     and has an odd number (1) of prime factors

17:24 >

To turn off this feature, set $VERBOSE to False.

Definition
----------
For n ∈ N, μ(n) =
   1 if n = 1 or n is square-free and has an even number of prime factors
  −1 if          n is square-free and has an odd  number of prime factors
   0 otherwise, i.e., if n has a squared prime factor.

Algorithm
---------
 1. Using Raku's in-built is-prime() method, find the prime factors of n by
    testing each prime number p (beginning with the smallest and working
    upwards) to find whether it is a factor of n (n mod p = 0): if it is,
    record it as a prime factor, divide n by p, and repeat the process (begin-
    ning again with p) until n = 1. The prime factors are returned as an AoA in
    which each factor is coupled with its exponent. E.g., the prime factors of
    120 are returned as ( [2, 3], [3, 1], [5, 1] ) denoting 2³ × 3¹ × 5¹.
 2. Analyse the prime factors of n using the definition of Moebius numbers (see
    above) to determine μ(n). Print the result.
 3. Optionally, print an explanation of the result.

References
----------
[1] "A008683  Möbius (or Moebius) function mu(n). mu(1) = 1; mu(n) = (-1)^k if
     n is the product of k different primes; otherwise mu(n) = 0.", OEIS,
     https://oeis.org/A008683
[2] "Möbius function", Wikipedia,
     https://en.wikipedia.org/wiki/M%C3%B6bius_function

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 159, Task #2: Moebius Number (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $n where * > 0                 #= A natural number
)
#==============================================================================
{
    "Input:  \$n = $n".put;

    my Array[UInt] @prime-factors = prime-factors( $n );
    my UInt        @exponents     = @prime-factors.map: { $_[1] };

    my Int $mu = @exponents.any >= 2 ?? 0 !!
                +@exponents   %%   2 ?? 1 !! -1;

    "Output: $mu".put;

    explain( $n, @prime-factors, $mu ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub prime-factors( UInt:D $n --> Array:D[Array:D[UInt:D]] )
#------------------------------------------------------------------------------
{
    my Array[UInt] @factors = Array[UInt].new;

    if $n.is-prime
    {
        @factors.push: Array[UInt].new( [$n, 1] );
    }
    else                                      # n is non-prime (1 or composite)
    {
        my UInt $rem = $n;

        for 0 .. $n -> UInt $p
        {
            if $p.is-prime && $rem %% $p
            {
                my $exp = 0;

                while $rem %% $p
                {
                    $rem = ($rem / $p).floor;
                    ++$exp;
                }

                @factors.push: Array[UInt].new( [$p, $exp] );

                last if $rem == 1;
            }
        }

        $rem == 1 or die "Impossible case: \$rem = $rem";
    }

    return @factors;
}

#------------------------------------------------------------------------------
sub explain( UInt:D $n, Array:D[UInt:D] $prime-factors, Int:D $mu )
#------------------------------------------------------------------------------
{
    "\nExplanation: ".print;

    if $n == 1
    {
        '1 has no prime factors; mu(1) = 1 by definition'.put;
    }
    else
    {
        ("%d has prime factor%s %s,\n             " ~
         'so mu(%d) = %d because %d ').printf:
            $n, +$prime-factors == 1 ?? '' !! 's',
            $prime-factors.map( { $_[0] ~ '^' ~ $_[1] } ).join( '.' ),
            $n, $mu, $n;

        if $mu == 0
        {
            my @p = $prime-factors.grep: { $_[1] > 1 };

            "has a squared prime factor (%d)\n".printf: @p[0; 0];
        }
        else
        {
            my $count = [+] $prime-factors.map: { $_[1] };

            ("is square-free\n             " ~
             "and has an %s number (%d) of prime factors\n").printf:
                $mu == 1 ?? 'even' !! 'odd', $count;
        }
    }
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
