#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub is_lychrel {
    my $m = shift;
    my $n = $m;
    for my $i (1..500) {
        return "$m is a Lychrel candidate. Reached the 1e7 limit"
            if $n > 10_000_000;
        $n += reverse $n;
        return 0 if $n == reverse $n;
    }
    return "$m is a lychrel candidate (made 500 iterations)";
}
for my $test (10..20, 30, 50, 100, 196) {
    say "$test -> ", is_lychrel $test;
}
