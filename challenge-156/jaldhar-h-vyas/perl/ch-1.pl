#!/usr/bin/perl
use 5.030;
use warnings;

sub isPrime {
    my ($n) = @_;

    if ($n < 2) {
        return undef;
    }

    if ($n == 2) {
        return 1;
    }

    for my $i (2 .. sqrt($n)) {
        if ($n % $i == 0) {
            return undef;
        }
    }

    return 1;
}

my @pernicious;
my $count = 2;

while (scalar @pernicious < 10) {
    my @binary = split //, sprintf '%b', $count;
    if (isPrime( scalar grep { $_ eq '1'} @binary)) {
        push @pernicious, $count;
    }
    $count++;
}

say join q{, }, @pernicious;
