#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;
use constant MAX => 400;

my @primes = (2, 3, 5, 7);
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
my %primes = map { $_ => 1} @primes;

sub prime_factors {
    my $num = shift;
    my $origin_num = $num;
    my @factors;
    for my $div (@primes) {
        while ($num % $div == 0) {
            push @factors, $div;
            $num /= $div;
        }
        return @factors if $num == 1;
    }
    push @factors, $num unless $num == $origin_num;
    return @factors;
}

sub add_digits {
my $sum = 0;
    for my $i (@_) {
        $sum += $_ for split //, $i;
    }
    return $sum;
}
# say join " ", prime_factors $_ for grep {not exists $primes{$_}} 2..50;

my @result;
my $count = 0;
my $i = 2;
while (1) {
    $i++;
    next if exists $primes{$i}; # we want composite numbers only
    my @factors = prime_factors $i;
    push @result, $i and $count++ if add_digits($i) == add_digits(@factors);
    last if $count >= 10;
}
say "@result";
