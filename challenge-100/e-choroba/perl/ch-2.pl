#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub triangle_sum {
    my ($triangle) = @_;
    my @sums = @{ $triangle->[-1] };
    @sums = map {
        $sums[$sums[ $_ - 1 ] < $sums[$_] ? $_ - 1 : $_]
            + $triangle->[@sums - 2][ $_ - 1 ]
        } 1 .. $#sums
        while @sums > 1;
    return $sums[0]
}

sub triangle_sum_show {
    my ($triangle) = @_;
    my @sums = @{ $triangle->[-1] };
    my @way;
    while (@sums > 1) {
        unshift @way, [];
        @sums = map {
            my $i = $sums[ $_ - 1 ] < $sums[$_] ? $_ - 1 : $_;
            push @{ $way[0] }, $i;
            $sums[$i] + $triangle->[@sums - 2][ $_ - 1 ];
        } 1 .. $#sums;
    }
    unshift @way, [];
    my $previous;
    for my $row (@$triangle) {
        my @selected = @{ $way[$#$row] };
        $previous = @selected ? $selected[$previous] : 0;
        print ' ' x (@$triangle - @$row);
        for my $i (0 .. $#$row) {
            print ' ', $i == $previous ? "[$row->[$i]]" : $row->[$i];
        }
        print "\n";
    }
}

use Test::More;

is triangle_sum([[1], [2, 4], [6, 4, 9], [5, 1, 7, 2]]), 8, 'Example 1';
is triangle_sum([[3], [3, 1], [5, 2, 3], [4, 3, 1, 3]]), 7, 'Example 2';

is triangle_sum([[2], [1, 5], [9, 10, 1]]), 8, 'Tricky';

done_testing();

my $triangle = [ map [map int rand 10, 1 .. $_], 1 .. 20 ];
triangle_sum_show($triangle);
say triangle_sum($triangle);

