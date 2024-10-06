#!/usr/bin/env perl

# Challenge 169
#
# Task 2: Achilles Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 20 Achilles Numbers. Please checkout wikipedia
# for more information.
#
#     An Achilles number is a number that is powerful but imperfect (not a
#     perfect power). Named after Achilles, a hero of the Trojan war, who was
#     also powerful but imperfect.
#
#     A positive integer n is a powerful number if, for every prime factor p of
#     n, p^2 is also a divisor.
#
#     A number is a perfect power if it has any integer roots (square root, cube
#     root, etc.).
#
# For example 36 factors to (2, 2, 3, 3) - every prime factor (2, 3) also has its
# square as a divisor (4, 9). But 36 has an integer square root, 6, so the number
# is a perfect power.
#
# But 72 factors to (2, 2, 2, 3, 3); it similarly has 4 and 9 as divisors, but it
# has no integer roots. This is an Achilles number.
#
# Output
#
#  72, 108,  200,  288,  392,  432,  500,  648,  675,  800,  864, 968, 972, 1125,
#  1152, 1323, 1352, 1372, 1568, 1800

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

sub is_powerfull {
    my($n) = @_;
    my @factors = prime_factors($n);
    for (@factors) {
        return 0 if $n % ($_*$_) != 0;
    }
    return 1;
}

sub is_perfect {
    my($n) = @_;
    for my $e (2..$n) {
        my $b = 1;
        for my $b (1..$n) {
            my $power = $b ** $e;
            return 1 if $power == $n;
            last if $power > $n;
            $b++;
        }
    }
    return 0;
}

sub is_aquilles {
    my($n) = @_;
    return is_powerfull($n) && !is_perfect($n);
}

sub aquilles_seq {
    my($n) = 1;
    return sub {
        while (1) {
            $n++;
            return $n if is_aquilles($n);
        }
    };
}

@ARGV==1 or die "usage: ch-2.pl n\n";
my $n=shift;
my @aquilles;
my $it = aquilles_seq();
push @aquilles, $it->() while @aquilles < $n;
say join ", ", @aquilles;
