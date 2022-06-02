#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(say);

# Write a script to find out first 10 circular primes having at least 3 digits (base 10).
# A circular prime is a prime number with the property that the number generated at each 
# intermediate step when cyclically permuting its (base 10) digits will also be prime.
#
# Output
# 113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933

sub is_prime {
    my $n = shift;
    return 0 if $n < 2;
    for my $i ( 2 .. int( $n**0.5 ) ) {
        return 0 if $n % $i == 0;
    }
    return 1;
}

sub is_circular_prime {
    my $n = shift;

    return if $n =~ m/[^1379]/;

    my @rotations;
    for ( 1 .. length $n ) {
        return unless is_prime($n);
        push @rotations, $n;
        $n = chop($n) . $n;
    }
    return \@rotations;
}

sub find_first_10_circular_primes {
    my @primes;
    my %seen;
    my $i = 100;
    while ( @primes < 10 ) {
        $i++;
        my $circular_prime = is_circular_prime($i);
        next unless $circular_prime;

        push @primes, $i unless $seen{$i};
        $seen{$_}++ for @$circular_prime;
    }
    return @primes;
}

say for find_first_10_circular_primes();

__END__

use Test::More;
use Test::Deep;

ok is_prime(2),   '2 is prime';
ok is_prime(3),   '3 is prime';
ok is_prime(197), '197 is prime';
ok !is_prime(4),  '4 is not prime';

cmp_deeply( is_circular_prime(197), bag( 197, 971, 719 ),
    'is_circular_prime(197)' );
cmp_deeply( is_circular_prime(199), bag( 199, 991, 919 ),
    'is_circular_prime(199)' );
cmp_deeply( is_circular_prime(337), bag( 337, 733, 373 ),
    'is_circular_prime(337)' );

for my $i ( 4, 10, 55, 100 ) {
    ok !is_circular_prime($i), "$i is not a circular prime";
}

cmp_deeply(
    [ find_first_10_circular_primes() ],
    [ 113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933 ],
    'Find the first 10 circular primes'
);
done_testing;

