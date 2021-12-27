#!/usr/bin/perl
use warnings;
use strict;

{   package Semiprime;
    use Moo;
    has _primes => (is => 'rw', default => sub { [2, 3] });

    sub is_semiprime {
        my ($self, $n) = @_;
        $self->_extend_primes while $n > $self->_primes->[-1];
        for my $p (@{ $self->_primes }) {
            return $self->_is_prime($n / $p) ? 1 : 0
                if 0 == $n % $p;
        }
        return 0
    }

    sub _extend_primes {
        my ($self) = @_;
        my $candidate = $self->_primes->[-1];

      CANDIDATE:
        while ($candidate += 2) {
            for my $p (@{ $self->_primes }) {
                next CANDIDATE if 0 == $candidate % $p;
            }
            last CANDIDATE
        }
        push @{ $self->_primes }, $candidate;
    }

    sub _is_prime {
        my ($self, $n) = @_;
        return 0 if $n <= 1;

        for my $p (@{ $self->_primes }) {
            return $p == $n if 0 == $n % $p;
        }
        return
    }
}

use Test2::V0;
plan 6;

my $s = 'Semiprime'->new;

is $s->is_semiprime(10), 1, 'Example 1';
is $s->is_semiprime(15), 1, 'Example 2';

is $s->is_semiprime(1), 0, 'One';
is $s->is_semiprime(23), 0, 'Prime';
is $s->is_semiprime(30), 0, 'Three primes';

my @under100 = grep $s->is_semiprime($_), 0 .. 100;
is \@under100, [4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, 39, 46,
                49, 51, 55, 57, 58, 62, 65, 69, 74, 77, 82, 85, 86, 87, 91, 93,
                94, 95],
    'List <= 100'; # From Wikipedia.
