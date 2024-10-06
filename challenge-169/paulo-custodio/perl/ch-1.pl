#!/usr/bin/env perl

# Challenge 169
#
# Task 1: Brilliant Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 20 Brilliant Numbers.
#
#     Brilliant numbers are numbers with two prime factors of the same length.
#
# The number should have exactly two prime factors, i.e. it's the product of two
# primes of the same length.
#
# For example,
#
# 24287 = 149 x 163
# 24289 = 107 x 227
#
# Therefore 24287 and 24289 are 2-brilliant numbers.
# These two brilliant numbers happen to be consecutive as there are no even
# brilliant numbers greater than 14.
#
#
# Output
#
# 4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221, 247, 253,
# 289, 299

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

sub prime_factors {
    my($n) = @_;
    my @factors;
    my $p = 0;
    while ($n > 1) {
        do { $p++; } while (!is_prime($p));
        while ($n % $p == 0) {
            push @factors, $p;
            $n /= $p;
        }
    }
    return @factors;
}

sub is_brillant {
    my($n) = @_;
    my @factors = prime_factors($n);
    return @factors==2 &&
           is_prime($factors[0]) && is_prime($factors[1]) &&
           length($factors[0]) == length($factors[1]);
}

sub brillant_seq {
    my $n = 1;
    return sub {
        while (1) {
            $n++;
            return $n if is_brillant($n);
        }
    };
}

@ARGV==1 or die "usage: ch-1.pl n\n";
my $n=shift;
my @brillant;
my $it = brillant_seq();
push @brillant, $it->() while @brillant < $n;
say join ", ", @brillant;
