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

say sum(@ints) - sum(map { split //, $_ } @ints);
