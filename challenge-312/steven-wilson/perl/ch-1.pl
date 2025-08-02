#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub minimumTime{
    my $string = shift;
    my $pointer = 'a';
    my $time = 0;

    for my $c (split //, $string){
        my $delta = abs(ord($pointer) - ord($c));
        $time += $delta > 13 ? 26 - $delta: $delta;
        $time++;
        $pointer = $c;
    }
    return $time;
}

is(minimumTime("abc"),   5, "Example 1");
is(minimumTime("bza"),   7, "Example 2");
is(minimumTime("zjpc"), 34, "Example 3");

done_testing();
