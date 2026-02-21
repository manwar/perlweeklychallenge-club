#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

my @remaining = pick_values(@ARGV);
say @remaining ? $remaining[0] : 0;

sub pick_values {
    my(@nums) = @_;
    while (@nums > 1) {
        @nums = sort {$b <=> $a} @nums;
        my($x, $y) = splice(@nums, 0, 2);
        if ($x != $y) {
            push @nums, $x - $y;
        }
    }
    return @nums;
}
