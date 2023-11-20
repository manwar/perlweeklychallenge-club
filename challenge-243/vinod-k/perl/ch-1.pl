#!/usr/bin/perl

use strict;
use warnings;

my @a = (2, 4, 3, 5, 1);

my $cnt = getReversePairs(@a);
print "Number of reverse pairs: $cnt\n";

sub getReversePairs {
    my (@arr) = @_;
    my $n = scalar @arr;

    my $count = 0;
    my ($i, $j) = 0;

    for ($i = 0 ; $i < $n ; $i++) {
        for ($j = $i + 1 ; $j < $n ; $j++) {
            if ($arr[$i] > (2 * $arr[$j])) {
                $count += 1;
            }
        }
    }
    return $count;
}
