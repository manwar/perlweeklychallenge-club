#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use constant PRIMES => (2, 3, 5, 7);

sub prime_factors {
    my $num = shift;
    my $origin_num = $num;
    my @factors;
    for my $div (PRIMES) {
        while ($num % $div == 0) {
            push @factors, $div;
            $num /= $div;
        }
        return @factors if $num == 1;
    }
    push @factors, $num unless $num == $origin_num;
    return @factors;
}

my %primes = map { $_ => 1 } PRIMES;
say "$_: ", join " ", prime_factors($_) for
    grep exists $primes{scalar prime_factors($_)}, 1..50;
