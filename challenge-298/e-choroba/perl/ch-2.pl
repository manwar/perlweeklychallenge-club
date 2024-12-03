#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# This implementation uses binary search to find the right interval, so it's
# faster for longer interval lists.
sub right_interval(@intervals) {
    my $i = 0;
    my @with_order = sort { $a->[0] <=> $b->[0] } map [@$_, $i++], @intervals;
    my @right;
    for my $i (0 .. $#with_order) {
        my $end = $with_order[$i][1];
        my $l = $i;
        my $r = $#with_order;
        while ($l != $r) {
            my $m = int(($l + $r) / 2);
            if ($with_order[$m][0] < $end) {
                $l = $m + 1;
            } else {
                $r = $m;
            }
        }
        $right[ $with_order[$i][2] ]
            = ($r == $#with_order && $with_order[$r][0] < $end)
              ? -1
              : $with_order[$r][2];
    }
    return \@right
}

# This implementaion scans all the intervals up to the right interval, so it
# gets slow for longer interval lists.
sub right_interval_short(@intervals) {
    my $i = 0;
    my @with_order = sort { $a->[0] <=> $b->[0] } map [@$_, $i++], @intervals;
    my @right;
    for my $i (0 .. $#with_order) {
        my $end = $with_order[$i][1];
        my $j = $i;
        ++$j while $j <= $#with_order && $with_order[$j][0] < $end;
        $right[ $with_order[$i][2] ] = $j > $#with_order
                                       ? -1
                                       : $with_order[$j][2];
    }
    return \@right
}

use Test2::V0;
plan(4 * 2 + 5);

use enum qw( NAME CODE );

for my $right_interval ([short => \&right_interval_short],
                        [long  => \&right_interval]
) {
    is $right_interval->[CODE]([3, 4], [2, 3], [1, 2]), [-1, 0,  1],
        "Example 1 $right_interval->[NAME]";
    is $right_interval->[CODE]([1, 4], [2, 3], [3, 4]), [-1, 2, -1],
        "Example 2 $right_interval->[NAME]";
    is $right_interval->[CODE]([1, 2]), [-1],
        "Example 3 $right_interval->[NAME]";
    is $right_interval->[CODE]([1, 4], [2, 2], [3, 4]), [-1, 1, -1],
        "Example 4 $right_interval->[NAME]";
}

use Benchmark qw{ cmpthese };

for my $size (50, 100, 500, 1_000, 5_000) {
    my %uniq;
    @uniq{ map int rand $size, 1 .. $size } = ();
    $uniq{$_} = $_ + int rand($size / 2) for keys %uniq;
    my @long = map [$_, $uniq{$_}], keys %uniq;
    is right_interval_short(@long), right_interval(@long), "same $size";

    cmpthese(-3, {
        "short $size" => sub { right_interval_short(@long) },
        "binsr $size" => sub { right_interval(@long) }
    });
}
