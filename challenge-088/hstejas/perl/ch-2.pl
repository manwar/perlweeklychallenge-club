#!/usr/bin/env perl

use strict;
use warnings;
use v5.30;
use Data::Dumper;



sub print_spiral {
    my $in = shift;
    my $m = scalar @{$in};
    my $n = scalar @{$in->[0]};
    my @res;
    # only works with $m == $n
    for my $done (0..$m) {
        # Right
        for(my $i = $done; $i < ($m - $done); $i++) {
            push @res, $in->[$done][$i];
        }
        # Down
        for(my $i = $done + 1; $i < ($n - $done); $i++) {
            push @res, $in->[$i][$n - $done - 1];
        }
        # Left
        for(my $i = $m - $done - 2; $i >= $done; $i--) {
            push @res, $in->[$m - $done - 1][$i];
        }
        # Up
        for(my $i = $n - $done - 2; $i > $done; $i--) {
            push @res, $in->[$i][$done];
        }
    }
    say join ', ', @res;
}

my $in1 = [
    [ 1, 2, 3 ],
    [ 4, 5, 6 ],
    [ 7, 8, 9 ],
];

print_spiral($in1);


my $in2 = [
    [  1,  2,  3,  4 ],
    [  5,  6,  7,  8 ],
    [  9, 10, 11, 12 ],
    [ 13, 14, 15, 16 ],
];

print_spiral($in2);