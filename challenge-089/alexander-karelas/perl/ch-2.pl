#!/usr/bin/env perl

use v5.30;
use warnings;

# 0 1 2
# 3 4 5
# 6 7 8

# x y
# z w

my @winning_rows = (
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
);

my %available_numbers;

sub reset_available {
    %available_numbers = map {($_, 1)} (1 .. 9);
}

for my $x (1 .. 9) {
    for my $y (1 .. 9) {
        next if $y == $x;
        for my $z (1 .. 9) {
            next if $z == $y or $z == $x;
            for my $w (1 .. 9) {
                next if $w == $z or $w == $y or $w == $x;
                reset_available();
                delete @available_numbers{($x, $y, $z, $w)};
                my $num_0_2 = 15 - $x - $y;
                next unless delete $available_numbers{$num_0_2};
                my $num_1_2 = 15 - $z - $w;
                next unless delete $available_numbers{$num_1_2};
                my $num_2_0 = 15 - $x - $z;
                next unless delete $available_numbers{$num_2_0};
                my $num_2_1 = 15 - $y - $w;
                next unless delete $available_numbers{$num_2_1};
                my $num_2_2 = 15 - $num_2_0 - $num_2_1;
                next unless delete $available_numbers{$num_2_2};

                next unless $x + $w + $num_2_2 == 15;
                next unless $num_0_2 + $w + $num_2_0 == 15;

                print "[ $x $y $num_0_2 ]\n";
                print "[ $z $w $num_1_2 ]\n";
                print "[ $num_2_0 $num_2_1 $num_2_2 ]\n";
                print "=================\n";
            }
        }
    }
}
