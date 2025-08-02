#!/usr/bin/perl
use 5.030;
use warnings;

sub sum {
    my $total;
    for my $n (@_) {
        $total += $n;
    }

    return $total;
}

my @ints = @ARGV;

say abs(sum(@ints) - sum(map { sum(split //, $_) } @ints));

