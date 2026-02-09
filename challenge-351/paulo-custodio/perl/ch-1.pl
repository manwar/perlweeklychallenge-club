#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

say special_average(@ARGV);

sub special_average {
    my(@nums) = @_;
    return 0 if @nums==0;
    @nums = sort {$a<=>$b} @nums;
    @nums = grep {$_ != $nums[0] && $_ != $nums[-1]} @nums;
    return 0 if @nums==0;
    return $nums[0] if @nums==1;
    my $sum; $sum += $_ for @nums;
    return $sum / scalar(@nums);
}
