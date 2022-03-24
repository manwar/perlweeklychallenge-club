#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util qw< sum product >;

my @inputs = @ARGV ? @ARGV : (1, 3, 5, 6, 9);
printf "AM = %.1f, GM = %.1f, HM = %.1f\n",
  arithmetic_mean(@inputs),
  #geometric_mean(@inputs),
  gmalt(@inputs),
  harmonic_mean(@inputs);

sub arithmetic_mean (@n) { sum(@n) / @n }
sub geometric_mean  (@n) { abs(product(@n)) ** (1 / @n) }
sub harmonic_mean   (@n) { 1 / arithmetic_mean(map { 1 / $_ } @n) }

use List::Util 'reduce';
sub gmalt (@n) { (reduce {$a * $b} @n) ** (1 / @n) }
