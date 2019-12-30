#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);

# Write a script to display attractive number between 1 and 50.
#
# A number is an attractive number if the number of its prime factors is
# also prime number.
#
# The number 20 is an attractive number, whose prime factors are 2, 2
# and 5. The total prime factors is 3 which is also a prime number.

my $N = 50;

# Find the primes up to $n using the Sieve of Eratosthenes
sub primes_up_to($n) {
    my %primes = map { $_ => 1 } 2..$n;
    for my $i (2..sqrt($n)) {
        if (defined $primes{$i}) {
            for (my $j = $i**2; $j <= $n; $j += $i) {
                delete $primes{$j};
            }
        }
    }
    return %primes;
}

sub prime_factors($n, %primes) {
    my @factors;

    for my $i (sort { $a<=>$b } keys %primes) {
        while ($n % $i == 0) {
            push @factors, $i;
            $n /= $i;
        }
    }
    return @factors;
}

my %primes = primes_up_to($N);
for my $i (1..$N) {
    say $i if defined $primes{scalar prime_factors($i, %primes)};
}
