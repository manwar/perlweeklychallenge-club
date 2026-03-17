#!/usr/bin/env perl

use Modern::Perl;

sub sum_squares_special_nums {
    my(@nums) = @_;
    my $sum = 0;
    for my $i (1 .. @nums) {
        if (scalar(@nums) % $i == 0) {
            $sum += $nums[$i-1] * $nums[$i-1];
        }
    }
    return $sum;
}

say sum_squares_special_nums(@ARGV);
