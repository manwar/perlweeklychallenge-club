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

my @n = @ARGV;
if (!scalar @n) {
    die "need an array of integers\n";
}

for my $i (0 .. (scalar @n - 1)) {
    if (sum([@n[0 .. $i - 1]]) == sum([@n[$i + 1 .. scalar @n - 1]])) {
        say $i;
        exit;
    }
}

say -1;
