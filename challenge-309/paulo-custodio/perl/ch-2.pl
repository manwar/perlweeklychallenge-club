#!/bin/env perl

use Modern::Perl;

my @list = @ARGV;
say min_diff(@list);

sub min_diff {
    my(@list) = @_;

    my $min_diff = abs($list[0]-$list[-1]); # any two elements
    for my $i (0 .. $#list-1) {
        for my $j ($i+1 .. $#list) {
            my $diff = abs($list[$i]-$list[$j]);
            $min_diff = $diff if $diff < $min_diff;
        }
    }
    return $min_diff;
}
