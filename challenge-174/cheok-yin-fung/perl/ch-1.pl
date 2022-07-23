#!/usr/bin/perl
# The Weekly Challenge 174
# Task 1 Disarium Numbers
use v5.30.0;
use warnings;

my $d = 0;
my $n = 0;
while ($d < 19) {
    my @arr = split "", $n;
    my $total = 0;
    $total += $arr[$_]**($_+1) for 0..$#arr;
    if ($total == $n) {
        say $n;
        $d++;
    }
    $n++;
}

=pod
0 to 9
89
135
175
518
598
1306
1676
2427
2646798

