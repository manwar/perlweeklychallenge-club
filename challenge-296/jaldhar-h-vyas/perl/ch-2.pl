#!/usr/bin/perl
use v5.38;

sub max(@list) {
    my $max = '-Inf';
    for my $n (@list) {
        if ($n > $max) {
            $max = $n;
        }
    }

    return $max;
}

sub sum(@list) {
    my $total;
    for my $n (@list) {
        $total += $n;
    }

    return $total;
}

my $side = sum(@ARGV) / 4;
say $side == int($side) && max(@ARGV) <= $side ? 'true' : 'false';