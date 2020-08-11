#!perl

################################################################################
=comment

Perl Weekly Challenge 022
=========================

Task #1
-------
Write a script to print first *10 Sexy Prime Pairs*. Sexy primes are prime
numbers that differ from each other by 6. For example, the numbers 5 and 11 are
both sexy primes, because *11 - 5 = 6*. The term *"sexy prime"* is a pun
stemming from the Latin word for six: sex. For more information, please checkout
wiki [ https://en.wikipedia.org/wiki/Sexy_prime |page].

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use feature           qw( say );
use Const::Fast;
use Math::Prime::Util qw( next_prime is_prime );

const my $DIFFERENCE =>  6;
const my $TARGET     => 10;

MAIN:
{
    my @pairs;
    my $prime = 1;

    while (scalar @pairs < $TARGET)
    {
           $prime   = next_prime($prime);
        my $partner = $prime + $DIFFERENCE;

        push @pairs, [$prime, $partner] if is_prime($partner);
    }

    say "\nThe first $TARGET sexy prime pairs are:\n",
         join(', ', map { sprintf '(%2d, %2d)', @$_ } @pairs);
}

################################################################################
