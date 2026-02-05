#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

say is_ap(@ARGV) ? 'true' : 'false';

sub is_ap {
    my(@nums) = @_;
    return if @nums < 3;
    @nums = sort {$a<=>$b} @nums;
    my $delta = $nums[1] - $nums[0];
    for my $i (1 .. $#nums - 1) {
        return if $nums[$i+1] - $nums[$i] != $delta;
    }
    return 1;
}
