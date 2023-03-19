#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 3;

# Subroutine to compute prime factors of a number
sub prime_decomposition {
    my $n = shift;

    # Check if number is less than 2
    if ($n < 2) {
        die "Number should be greater than or equal to 2\n";
    }

    my @factors = ();
    my $d = 2;

    # Divide the number by prime factors
    while ($n > 1) {
        while ($n % $d == 0) {
            push @factors, $d;
            $n /= $d;
        }
        $d++;
        if ($d * $d > $n && $n > 1) {
            push @factors, $n;
            last;
        }
    }

    return @factors;
}

# Test cases
is_deeply([prime_decomposition(228)], [2, 2, 3, 19], "prime decomposition of 228");
is_deeply([prime_decomposition(131)], [131], "prime decomposition of 131");
is_deeply([prime_decomposition(101)], [101], "prime decomposition of 101");

done_testing();


