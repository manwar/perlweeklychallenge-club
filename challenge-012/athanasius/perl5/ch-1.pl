#!perl

################################################################################
=comment

Perl Weekly Challenge 012
=========================

Challenge #1
------------

The numbers formed by adding one to the products of the smallest primes are
called the Euclid Numbers (see [ https://en.wikipedia.org/wiki/Euclid_number 
|wiki]). Write a script that finds the smallest *Euclid Number* that is not
prime. This challenge was proposed by Laurent Rosenfeld.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 Perlmonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Math::Prime::Util qw( factor is_prime pn_primorial );

$| = 1;

MAIN:
{
    for (my $n = 1; ; ++$n)
    {
        my $euclid = pn_primorial($n) + 1;

        # is_prime() "Returns 0 is the number is composite,
        #                     1 if it is probably prime,
        #                 and 2 if it is definitely prime."

        if (is_prime($euclid) == 0)
        {
            printf "\nThe smallest composite Euclid number E_n is:\n" .
                     "  E_%d = (%d# + 1) = %s = %s\n",
                      $n, $n, commify($euclid), join(' * ', factor($euclid));
            last;
        }
    }
}

sub commify
{
    my ($number) = @_;

    # Regex from perlfaq5: "How can I output my numbers with commas added?"

    return $number =~ s/(^\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/gr;
}

################################################################################
