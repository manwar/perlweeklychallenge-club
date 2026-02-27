#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say longest_sequence(@ARGV);

sub longest_sequence {
    my(@nums) = @_;
    @nums = sort {$a<=>$b} @nums;
    my $longest = -1;
    while (@nums) {
        my $i = 1;
        while ($i < @nums && $nums[$i-1]+1 == $nums[$i]) {
            $i++;
        }
        my $length = $i;
        if ($length >= 2) {
            $longest = $length if $longest < $length;
        }
        splice(@nums, 0, $i);
    }
    return $longest;
}
