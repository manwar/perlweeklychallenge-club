#!/usr/bin/perl
use v5.38;

sub sum {
    my $total;
    for my $n (@_) {
        $total += $n;
    }

    return $total;
}

my @ints = @ARGV;
my $sum;

for my $i (1 .. scalar @ints) {
    if ($i % 2 == 1) {
        for my $j (0 .. scalar @ints - $i) {
            $sum += sum(@ints[$j .. $j + $i - 1]);
        }
    }
}

say $sum;
