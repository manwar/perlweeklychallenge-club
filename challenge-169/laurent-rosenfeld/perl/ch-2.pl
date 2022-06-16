#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;
use constant MAX => 500;

my @primes = (2, 3, 5, 7);

# Greatest common divisor of two or more integers
sub gcd {
    if (@_ > 2) {
        return gcd( gcd($_[0], $_[1]), @_[2..$#_]);
    } else {
        my ($i, $j) = sort { $a <=> $b } @_;
        while ($j) {
            ($i, $j) = ($j, $i % $j);
        }
        return $i;
    }
}

# Creating a hash of prime factors (as keys) with their powers (as values)
sub prime_factors {
    my $num = shift;
    my $origin_num = $num;
    my %factors;
    for my $div (@primes) {
        while ($num % $div == 0) {
            $factors{$div}++;
            $num /= $div;
        }
        return %factors if $num == 1;
    }
    $factors{$num}++ unless $num == $origin_num;
    return %factors;
}


# Populating an array of primes up to MAX
my $current = 9;
while (1) {
    my $prime = 1;
    for my $i (@primes) {
        my $i_sq = $i * $i;
        last if $i_sq > $current;
        $prime = 0, last if $current % $i == 0;
    }
    push @primes, $current if $prime;;
    $current += 2;
    last if $current > MAX;
}

my $count = 0;
for my $n (1..MAX*MAX) {
    my %factors =  prime_factors $n;
    my @powers = map $factors{$_}, keys %factors;
    next if grep { $_ < 2} @powers;
    next if scalar @powers < 2;
    if (gcd(@powers) == 1) {
        printf "%4d -> %s\n", $n,  join " ", @powers;
        $count++;
        last if $count >= 20
    }

This script displays the following output:

$ perl  ./Achilles_nums.pl
  72 -> 2 3
 108 -> 2 3
 200 -> 3 2
 288 -> 5 2
 392 -> 3 2
 432 -> 3 4
 500 -> 3 2
 648 -> 4 3
 675 -> 2 3
 800 -> 2 5
 864 -> 3 5
 968 -> 3 2
 972 -> 5 2
1125 -> 2 3
1152 -> 2 7
1323 -> 2 3
1352 -> 2 3
1372 -> 2 3
1568 -> 5 2
1800 -> 2 2 3
