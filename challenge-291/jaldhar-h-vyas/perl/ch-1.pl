#!/usr/bin/perl
use v5.38;

sub sum(@list) {
    my $total;
    for my $n (@list) {
        $total += $n;
    }

    return $total;
}

my @ints = @ARGV;

my $mi = -1;

for my $i (keys @ints) {
    if ((sum(@ints[0 .. $i - 1]) // 0) == (sum(@ints[$i + 1 .. $#ints]) // 0)) {
        $mi = $i;
        last;
    }
}

say $mi;
