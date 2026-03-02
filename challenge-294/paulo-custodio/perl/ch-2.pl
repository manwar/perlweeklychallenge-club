#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

say "(", join(", ", next_permutation(@ARGV)), ")";

sub next_permutation {
    my(@nums) = @_;

    # Find the longest not increasing suffix
    my $pivot;
    for my $i (reverse 0 .. $#nums-1) {
        if ($nums[$i] < $nums[$i+1]) {
            $pivot = $i;
            last;
        }
    }
    return () unless defined $pivot;    # not found, sequence was lasy one

    # find the rightmost successor to the pivot
    my $successor;
    for my $i (reverse 0 .. $#nums) {
        if ($nums[$i] > $nums[$pivot]) {
            $successor = $i;
            last;
        }
    }

    # swap the pivot with the successor
    ($nums[$pivot], $nums[$successor]) = ($nums[$successor], $nums[$pivot]);

    # reverse suffix
    @nums[$pivot+1..$#nums] = reverse @nums[$pivot+1..$#nums];

    return @nums;
}
