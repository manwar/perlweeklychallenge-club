#!/usr/bin/perl
use warnings;
use strict;

{   package Prime::Generator;

    sub new { bless [2, 3], shift }

    sub xth_prime {
        my ($self, $x) = @_;
        my $p = $self->[-1] + 2;
      CANDIDATE:
        while (@$self < $x) {
            for my $q (@$self) {
                next CANDIDATE if 0 == $p % $q;

                last if $q * $q > $p;  # Optimisation.
            }
            push @$self, $p;
        } continue {
            $p += 2;
        }
        return $self->[ $x - 1 ]
    }
}

use Test2::V0;
plan 6;

my $pg = 'Prime::Generator'->new;

is $pg->xth_prime(1), 2, '1st prime = 2';
is $pg->xth_prime(2), 3, '2nd prime = 3';
is $pg->xth_prime(3), 5, '3rd prime = 5';
is $pg->xth_prime(10), 29, '10th prime = 29';
is $pg->xth_prime(5), 11, '5th prime (breaking the order) = 11';

is $pg->xth_prime(10001), 104743, '10001st Prime Number';
