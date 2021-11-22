#!/usr/bin/env perl

# TASK #2 > Long Primes
# Submitted by: Mohammad S Anwar
# Write a script to generate first 5 Long Primes.
#
# A prime number (p) is called Long Prime if (1/p) has an infinite decimal
# expansion repeating every (p-1) digits.
#
# Example
# 7 is a long prime since 1/7 = 0.142857142857...
# The repeating part (142857) size is 6 i.e. one less than the prime number 7.
#
# Also 17 is a long prime since 1/17 = 0.05882352941176470588235294117647...
# The repeating part (0588235294117647) size is 16 i.e. one less than the
# prime number 17.
#
# Another example, 2 is not a long prime as 1/2 = 0.5.
# There is no repeating part in this case.

use Modern::Perl;
use Math::BigFloat;
use ntheory 'next_prime';

Math::BigFloat->accuracy(1000);         # very long list of digits

my $N = shift||5;
my $prime = 2;
for (1..$N) {
    while (!is_long_prime($prime)) {
        $prime = next_prime($prime);
    }
    say $prime;
    $prime = next_prime($prime);
}

sub is_long_prime {
    my($p) = @_;
    my $inv = Math::BigFloat->new(1) / Math::BigFloat->new($p);
    if (rept_sequence($inv, $p-1)==$p-1) {
        return 1;
    }
    else {
        return 0;
    }
}

sub rept_sequence {
    my($n, $max) = @_;
    for my $rept (1..$max) {
        my $rept1 = $rept-1;
        my $code = "\$n =~ /\\.(\\d{$rept})\\1+\\d{0,$rept1}\$/;";
        if (eval $code) {
            return $rept;
        }
    }
    return -1;
}
