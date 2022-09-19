#!/usr/bin/perl
use 5.030;
use warnings;
use bigint;

sub product {
    my ($arr) = @_;
    my $total = 1;

    for my $elem (@{$arr}) {
        $total *= $elem;
    }

    return $total;
}

my @sylvesters = (2, 3);

while (scalar @sylvesters< 10) {
    push @sylvesters, product(\@sylvesters) + 1;
}

for (@sylvesters) {
    say;
}
