#!/usr/bin/env raku

#
# Perl Weekly Challenge - 073
#
# Task #1: Min Sliding Window
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-073
#

use Test;

my $list = "1, 5, 0, 2, 9, 3, 7, 6, 4, 8";
my %test-cases = (
    2 => "1, 0, 0, 2, 3, 3, 6, 4, 4",
    3 => "0, 0, 0, 2, 3, 3, 4, 4",
    4 => "0, 0, 0, 2, 3, 3, 4",
    5 => "0, 0, 0, 2, 3, 3",
    6 => "0, 0, 0, 2, 3",
    7 => "0, 0, 0, 2",
    8 => "0, 0, 0",
    9 => "0, 0",
   10 => "0",
);

for %test-cases.keys.sort({ $^a <=> $^b }) -> $size {
    is min-sliding-window($list, $size.Int).join(", "),
       %test-cases{$size},
       "testing size $size";
}

done-testing;

sub min-sliding-window(Str $list is copy, Int $size) {

    die "ERROR: Invalid list [$list].\n"
        unless $list ~~ /^[\-?\d\,?\s?]+$/;

    $list ~~ s:g/\s//;
    my $l = [ $list.split(',') ];

    die "ERROR: Invalid size [$size].\n"
        unless $size >= 2 && $size - 1 <= $l.elems;

    my $index = 0;
    my @min-sliding-window = Empty;

    while $index + $size - 1 < $l.elems {
        my $window = $l.[$index .. $index + $size - 1].map: { .Int };
        @min-sliding-window.push: min($window);
        $index++;
    }

    return @min-sliding-window;
}
