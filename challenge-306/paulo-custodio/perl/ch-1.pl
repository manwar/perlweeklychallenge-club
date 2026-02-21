#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(sum);

@ARGV or die "usage: $0 nums...\n";
say sum_odds(@ARGV);

sub sum_odds {
    my(@nums) = @_;
    my $sum = 0;
    for (my $len = 1; $len <= @nums; $len += 2) {
        for my $i (0 .. $#nums) {
            next if $i + $len > @nums;
            $sum += sum(@nums[$i .. $i + $len - 1]);
        }
    }
    return $sum;
}
