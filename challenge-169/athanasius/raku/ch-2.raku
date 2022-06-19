use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 169
=========================

TASK #2
-------
*Achilles Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate first 20 Achilles Numbers. Please checkout
[ https://en.wikipedia.org/wiki/Achilles_number |wikipedia] for more informa-
tion.

    An Achilles number is a number that is powerful but imperfect. Named after
    Achilles, a hero of the Trojan war, who was also powerful but imperfect.

    A positive integer n is a powerful number if, for every prime factor p of
    n, p^2 is also a divisor.

    A number is a perfect power if it has any integer roots (square root, cube
    root, etc.).

For example 36 factors to (2, 2, 3, 3) - every prime factor (2, 3) also has its
square as a divisor (4, 9). But 36 has an integer square root, 6, so the number
is a perfect power.

But 72 factors to (2, 2, 2, 3, 3); it similarly has 4 and 9 as divisors, but it
has no integer roots. This is an Achilles number.

Output

  72, 108,  200,  288,  392,  432,  500,  648,  675,  800,  864, 968, 972,
  1125, 1152, 1323, 1352, 1372, 1568, 1800

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
Note that the given definition of an imperfect number, viz., "has no integer
roots", can also be expressed in terms of the number's prime factors: a number
is imperfect if and only if the highest common factor of the exponents of its
prime factors is 1. [1]

Achilles numbers are identified as follows:

    Beginning with the number 2, successive integers are tested as follows:

        (1) Are they powerful? A number is powerful if and only if all of the
            exponents of its prime factors are greater than 1.
        (2) Are they imperfect? (see above).

    Numbers meeting both criteria are recorded as Achilles numbers.

Implementation
--------------
Routine prime-factors() is copied from the Raku solution to Week 168, Task 2.
Routine prime-factor-pairs() transforms the output of prime-factors() into an
array of prime-factor/exponent pairs; e.g., for $n = 360, the prime factors
[2, 2, 2, 3, 3, 5] become [[2, 3], [3, 2], [5, 1]].

Routine gcd() uses the Euclidean algorithm [3] to find the greatest common
divisor of the first two input numbers, then repeats the algorithm with the gcd
just found and the next input number, and so on until the input is exhausted.

References
----------
[1] "Achilles numbers - powerful but imperfect...", OEIS,
     https://oeis.org/A052486
[2] "Achilles number", Wikipedia, https://en.wikipedia.org/wiki/Achilles_number
[3] "Greatest common divisor", Wikipedia,
     https://en.wikipedia.org/wiki/Greatest_common_divisor

=end comment
#==============================================================================

my UInt constant $TARGET = 20;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 169, Task #2: Achilles Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @achilles;

    loop (my UInt $n = 2; +@achilles < $TARGET; ++$n)
    {
        my Array[UInt] @factor-pairs =  prime-factor-pairs( $n );
        my UInt        @exponents    =  @factor-pairs.map: { $_[ 1 ] };
        my Bool        $is-powerful  = (@exponents.all >= 2).so;

        if $is-powerful
        {
            my Bool $is-perfect = gcd( @exponents ) == 1;

            @achilles.push: $n if $is-perfect;
        }
    }

    "The first %d Achilles numbers:\n%s\n".printf:
        $TARGET, @achilles.join: ', ';
}

#------------------------------------------------------------------------------
sub prime-factor-pairs( UInt:D $n where * ≥ 2 --> Array:D[Array:D[UInt:D]] )
#------------------------------------------------------------------------------
{
    my UInt @prime-factors = prime-factors( $n );
    my UInt %factor2exp{UInt};

    for @prime-factors.sort -> UInt $factor
    {
        ++%factor2exp{ $factor };
    }

    my Array[UInt] @prime-factor-pairs;

    for %factor2exp.keys.sort -> UInt $factor
    {
        my UInt $exponent = %factor2exp{ $factor };

        @prime-factor-pairs.push: Array[UInt].new: $factor, $exponent;
    }

    return @prime-factor-pairs;
}

#------------------------------------------------------------------------------
sub prime-factors( UInt:D $n where * ≥ 2 --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @prime-factors;
    my UInt $dividend = $n;

    while $dividend %% 2
    {
        @prime-factors.push: 2;

        $dividend = ($dividend / 2).Int;
    }

    my UInt $start = 3;

    L-OUTER: while $dividend > 1
    {
        loop (my UInt $factor = $start; ; $factor += 2)
        {
            if $factor.is-prime && $dividend %% $factor
            {
                @prime-factors.push: $factor;

                $dividend = ($dividend / $factor).Int;
                $start    =  $factor;

                if $dividend.is-prime
                {
                    @prime-factors.push: $dividend;
                    last L-OUTER;
                }

                next L-OUTER;
            }
        }
    }

    return @prime-factors;
}

#------------------------------------------------------------------------------
sub gcd( *@nums where { +@nums ≥ 1 && .all ~~ UInt:D && .all ≥ 1 } --> UInt:D )
#------------------------------------------------------------------------------
{
    my UInt $a = @nums.shift;

    while +@nums
    {
        my UInt $b = @nums.shift;

        # Euclidean algorithm: "the algorithm replaces (a, b) by (b, a mod b)
        #                       repeatedly until the pair is (d, 0)" [3]

        ($a, $b) = $b, $a % $b until $b == 0;
    }

    return $a;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
