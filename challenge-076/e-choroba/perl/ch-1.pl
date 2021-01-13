#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my %prime = (1 => 0, 2 => 1, 3 => 1);
sub is_prime {
    my ($n) = @_;
    return $prime{$n} if exists $prime{$n};

    for my $d (2 .. sqrt $n) {
        next unless is_prime($d);

        return $prime{$n} = 0 if 0 == $n % $d;
    }
    return $prime{$n} = 1
}

my %prime_sum;
sub prime_sum {
    my ($n) = @_;
    return $prime_sum{$n} if exists $prime_sum{$n};

    return $prime_sum{$n} = 1 if is_prime($n);

    # Euler-Goldbach
    return $prime_sum{$n} = 2 if 0 == $n % 2;

    # Goldbach says we can only return 2 or 3.
    my $min = $n;
    for my $m (2 .. 1 + $n / 2) {
        no warnings 'recursion';
        my $sum = prime_sum($n - $m) + prime_sum($m);
        $min = $sum if $sum < $min;

        # We can't get less than 2.
        last if 2 == $min;
    }
    return $prime_sum{$n} = $min
}

use Test::More;

is prime_sum(2),  1, '2 = 2';
is prime_sum(3),  1, '3 = 3';
is prime_sum(4),  2, '4 = 2 + 2';
is prime_sum(5),  1, '5 = 5';
is prime_sum(6),  2, '6 = 3 + 3';
is prime_sum(7),  1, '7 = 7';
is prime_sum(8),  2, '8 = 3 + 5';
is prime_sum(9),  2, '9 = 2 + 7';
is prime_sum(10), 2, '10 = 3 + 7';
is prime_sum(11), 1, '11 = 11';
is prime_sum(27), 3, '27 = 2 + 2 + 23';
is prime_sum(51), 3, '51 = 2 + 2 + 47';
is prime_sum(1023), 2, '1023 = 2 + 1021';
is prime_sum(2047), 3, '2047 = 2039 + 3 + 5';

done_testing();
