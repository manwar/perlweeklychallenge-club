#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum };

# Adapted from PWC 114/2.
sub next_same_number_of_ones {
    my ($binary) = @_;

    if (-1 != (my $pos = rindex $binary, '01')) {
        substr $binary, $pos, 2, '10';
        my $suffix = substr $binary, $pos + 2, length $binary, "";
        my $ones = $suffix =~ tr/1//d;
        $suffix .= 1 x $ones;
        return "$binary$suffix";
    }

    my $pos = rindex $binary, '1';
    my $zeros = substr $binary, $pos + 1, length $binary, "";
    substr $binary, 1, 0, "0$zeros";
    return $binary
}

sub tug_of_war {
    my @ints = @_;
    my $length = @ints;
    my $size = $length / 2;
    my $mask = "%0${length}b";
    my $bin = sprintf $mask, 2 ** (int $size) - 1;
    my ($diff, $best1, $best2) = sum(@ints);
    while ($bin !~ /^1+0+$/) {
        my ($s1, $s2) = ([], []);
        for my $i (0 .. $length - 1) {
            push @{ ($s1, $s2)[ substr $bin, $i, 1 ] }, $ints[$i];
        }
        if (abs(sum(0, @$s1) - sum(0, @$s2)) < $diff) {
            $diff = abs(sum(0, @$s1) - sum(0, @$s2));
            ($best1, $best2) = ([@$s1], [@$s2]);
            last if 0 == $diff
        }
        $bin = next_same_number_of_ones($bin);
    }
    return $best1, $best2
}

use Test2::V0;
plan 2;

sub Check {
    my ($input, $arr1, $arr2, $name) = @_;
    is [tug_of_war(@$input)],
        bag { item bag { item $_ for @$arr1; end };
              item bag { item $_ for @$arr2; end };
        }, $name;
}

Check([10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
      [30, 40, 60, 70, 80],
      [10, 20, 50, 90, 100],
      'Example 1');

Check([10, -15, 20, 30, -25, 0, 5, 40, -5],
      [30, 0, 5, -5],
      [10, -15, 20, -25, 40],
      'Example 2');
