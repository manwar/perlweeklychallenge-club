#!/usr/bin/env perl
# Perl weekly challenge 158
# Task 1: Additive primes
#
# See https://wlmb.github.io/2022/03/28/PWC158/#task-1-additive-primes
use v5.12;
use warnings;
use Math::Prime::Util qw(primes is_prime);
use List::Util qw(sum);
die "Usage: ./ch-1.pl N\n\tto print additive primes up to N" unless @ARGV;
my $N=shift;
die "N should be positive" unless $N>0;
say "The additive primes up to $N are ",
    join ", ", grep {is_prime(sum split "", $_)} (@{primes($N)});
