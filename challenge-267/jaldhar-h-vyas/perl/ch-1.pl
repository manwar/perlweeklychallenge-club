#!/usr/bin/perl
use v5.38;

sub product(@terms) {
    my $result = 1;

    for my $term (@terms) {
        $result *= $term;
    }

    return $result;
}

sub sign($number) {
    return ($number > 0) ? 1 : ($number < 0) ? -1 : 0;
}

say sign(product(@ARGV));
