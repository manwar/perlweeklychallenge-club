#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say "(", join(", ", compare_order(@ARGV)), ")";

sub compare_order {
    my(@nums) = @ARGV;
    my @ordered = sort {$a <=> $b} @nums;
    my @indices;
    for (0 .. $#nums) {
        push @indices, $_ if $nums[$_] != $ordered[$_];
    }
    return @indices;
}
