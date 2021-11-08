#!/usr/bin/perl
use warnings;
use strict;

sub number_sequence {
    my ($n) = @_;
    my $ln = length $n;
    for my $length (1 .. $ln / 2) {
        my $start = substr $n, 0, $length;
        my $i = my $n2 = $start;
        $n2 .= ++$i while length $n2 < $ln;
        return [$start .. $i] if $n2 == $n;
    }
    return [$n]
}

use Test::More;

is_deeply number_sequence(1234), [1, 2, 3, 4], 'Example 1';
is_deeply number_sequence(91011), [9, 10, 11], 'Example 2';
is_deeply number_sequence(10203), [10203], 'Example 3';

is_deeply number_sequence(417418419420), [417, 418, 419, 420], 'Longer';
is_deeply number_sequence(80910), [80910], 'Leading zero';

done_testing();
