#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say distinct_average(@ARGV);

sub distinct_average {
    my(@nums) = @_;
    @nums = sort {$a<=>$b} @nums;
    my %averages;
    while (@nums) {
        my $average = ($nums[0] + $nums[-1]) / 2;
        $averages{$average} = 1;
        @nums = @nums[1 .. $#nums-1];
    }
    return scalar keys %averages;
}
