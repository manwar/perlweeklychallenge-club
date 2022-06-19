#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

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
All the hard work is delegated to routines factor_exp() and gcd() in the CPAN
module Math::Prime::Util:

    factor_exp( $n ) returns an array of prime-factor/exponent pairs; e.g.,
        factor_exp( 360 ) = ([2, 3], [3, 2], [5, 1]) meaning 360 = 2³ × 3² × 5¹

    gcd( $p, $q ) returns the greatest common divisor (aka the highest common
        factor) of $p and $q; e.g., gcd( 30, 72 ) = 6

References
----------
[1] "A052486  Achilles numbers - powerful but imperfect...", OEIS,
     https://oeis.org/A052486
[2] "Achilles number", Wikipedia, https://en.wikipedia.org/wiki/Achilles_number

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util        qw( all );
use Math::Prime::Util qw( factor_exp gcd );

const my $TARGET => 20;
const my $USAGE  => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 169, Task #2: Achilles Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my @achilles;

    for (my $n = 2; scalar @achilles < $TARGET; ++$n)
    {
        my @fact_exps   = factor_exp( $n );
        my @exponents   = map { $_->[ 1 ] } @fact_exps;
        my $is_powerful = all { $_ >= 2   } @exponents;

        if ($is_powerful)
        {
            my $is_perfect = gcd( @exponents ) == 1;

            push @achilles, $n if $is_perfect;
        }
    }

    printf "The first %d Achilles numbers:\n%s\n",
            $TARGET, join ', ', @achilles;
}

###############################################################################
