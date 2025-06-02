#!/usr/bin/env perl

use v5.40;

use Test2::V0;

sub total_xor ($ints) {
    my $max = 1;
    $max *= 2 foreach @$ints;
    my $total = 0;
    for my $i (1 .. $max-1) {
        my @bin = split //, sprintf('%0'. scalar(@$ints) .'b', $i);
        my $xor = 0;
        for (my $j = 0; $j < @bin; $j++) {
            $xor = ($xor ^ $ints->[$j]) if $bin[$j];
        }
        $total += $xor;
    }
    return $total;
}

is total_xor([1, 3]), 6, 'Example 1';
is total_xor([5, 1, 6]), 28, 'Example 2';

done_testing();
