#!/usr/bin/env perl

# Challenge 167
#
# Task 1: Circular Prime
# Submitted by: Mohammad S Anwar
#
# Write a script to find out first 10 circular primes having at least 3 digits
# (base 10).
#
# Please checkout wikipedia for more information.
#
#     A circular prime is a prime number with the property that the number
#     generated at each intermediate step when cyclically permuting its (base 10)
#     digits will also be prime.
#
# Output
#
# 113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933

use Modern::Perl;

sub is_prime {
    my($n) = @_;
    return 0 if $n <= 1;
    return 1 if $n <= 3;
    return 0 if ($n % 2)==0 || ($n % 3)==0;
    for (my $i = 5; $i*$i <= $n; $i += 6) {
        return 0 if ($n % $i)==0 || ($n % ($i+2))==0;
    }
    return 1;
}

sub next_prime {
    my($n) = @_;
    return 2 if $n <= 1;
    my $p = $n;
    1 while !is_prime(++$p);
    return $p;
}

sub is_circular_prime {
    my($n)=@_;
    state %seen;
    return 0 if $seen{$n}++;
    return 0 if $n<10;
    return 0 if $n =~ /[024568]/;
    my @rotations;
    for (1..length($n)) {
        push @rotations,$n;
        return 0 if !is_prime($n);
        $n=substr($n,1).substr($n,0,1);
    }
    $seen{$_}++ for @rotations;
    return 1;
}

sub next_circular_prime {
    my($n)=@_;
    $n++;
    while (!is_circular_prime($n)) {
        $n=next_prime($n);
    }
    return $n;
}

@ARGV==1 or die "usage: ch-1.pl n\n";
my $n=shift;
my @cprimes;
my $cp=1;
while (@cprimes<$n) {
    $cp=next_circular_prime($cp);
    push @cprimes,$cp if $cp>=100;
}
say join ", ", @cprimes;
