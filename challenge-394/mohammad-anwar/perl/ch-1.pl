#!/usr/bin/env perl

use v5.38;
use Test::More;
use List::Util qw(min);

my @examples = (
    { in => "aAbB",   out => 0 },
    { in => "AAbb",   out => 1 },
    { in => "AAAbbb", out => 3 },
    { in => "aABb",   out => 1 },
    { in => "aBBAaa", out => 2 },
);

is min_swaps($_->{in}), $_->{out} foreach @examples;

done_testing;

sub min_swaps($str) {
    my @chars = split //, $str;
    my $calc  = sub {
        my ($start_lower) = @_; # 1 for lower-first, 0 for upper-first
        my ($swaps, $target) = (0, 0);
        for my $i (0 .. $#chars) {
            my $is_lower = ($chars[$i] ge 'a' && $chars[$i] le 'z') ? 1 : 0;
            if ($is_lower == $start_lower) {
                $swaps  += abs($i - $target);
                $target += 2;
            }
        }
        return $swaps;
    };

    return min($calc->(1), $calc->(0));
}
