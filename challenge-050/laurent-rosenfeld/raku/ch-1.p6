#!/usr/bin/env perl6

use v6;

my @intervals = [2,7], [3,4], [5,9], [10,12], [15,19], [18,22], [0,1], [24,35], [25,30];
@intervals =  sort { $_[0] }, @intervals;
my @merged;
my $current = @intervals[0];
for 1..@intervals.end -> $i {
    if (@intervals[$i][0] > $current[1]) {
        push @merged, $current;
        $current = @intervals[$i];
    } else {
        next unless @intervals[$i][1] > $current[1];
        $current[1] = @intervals[$i][1];
    }
}
push @merged, $current;
say @merged;
