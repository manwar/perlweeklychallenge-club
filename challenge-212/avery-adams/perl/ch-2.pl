#!/bin/perl

use strict;
use v5.28;

my $size = shift;
my @list = sort @ARGV;

say '-1' and exit if scalar @list % $size != 0;
my $passes = (scalar @list / $size) - 1;

my @results;

for (my $i = 0; $i <= $passes; $i++) {
    my $curr_digit = 0;
    push @{$results[$i]}, $list[0];
    for (my $j = 1; $j <= $#list; $j++) {
        if ($list[$j] == $list[0] + $curr_digit + 1) {
            push @{$results[$i]}, $list[$j];
            splice (@list, $j, 1);
            if (scalar @{$results[$i]} == $size) {
                last;
            } else {
                $curr_digit++;
                $j--;
            }
        }
        if ($j == $#list and scalar @{$results[$i]} != $size) {say '-1' and exit}
    }
    splice (@list, 0, 1);
}

for (my $k = 0; $k <= $#results; $k++) {
    say @{$results[$k]};
}
