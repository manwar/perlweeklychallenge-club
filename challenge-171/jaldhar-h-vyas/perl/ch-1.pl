#!/usr/bin/perl
use 5.030;
use warnings;

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

my @abundants;
my $n = 1;

until (scalar @abundants == 20) {
    my @divisors;
    for my $i (1 .. $n / 2) {
        if ($n % $i == 0) {
            push @divisors, $i;
        }
    }

    if (sum(\@divisors) > $n) {
        push @abundants, $n;
    }

    $n += 2;
}

say join q{, }, @abundants;
