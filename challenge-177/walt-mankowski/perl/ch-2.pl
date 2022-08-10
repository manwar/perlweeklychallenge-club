#!/usr/bin/env perl
use v5.36;
use lib ".";
use primes qw(primes_to);

# Task 2: Palindromic Prime Cyclops
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 20 Palindromic Prime Cyclops Numbers.
#
#     A cyclops number is a number with an odd number of digits that
#     has a zero in the center only.

sub is_cyclops($n) {
    return length($n) % 2 == 1 &&
        substr($n, length($n)/2, 1) == 0 &&
        ($n =~ tr/0//) == 1 &&
        $n == reverse($n);
}

my $primes = primes_to(1600000);
my @ppc;
my $i = 0;
while (@ppc < 20 && $i < @$primes) {
    if (is_cyclops($primes->[$i])) {
        say $primes->[$i];
        push @ppc, $primes->[$i];
    }
    $i++;
}
