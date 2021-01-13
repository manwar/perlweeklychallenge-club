#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use feature qw /say/;

my @L = (-25, -10, -7, -3, 2, 4, 8, 10);

@L = sort { $a <=> $b } @L;

for (my $i = 0; $i < scalar(@L) - 2; $i++) {
    my $start = $i + 1;
    my $end   = scalar(@L) - 1;

    while ($start < $end) {
        if ($L[$i] + $L[$start] + $L[$end] == 0) {
            say "$L[$i] + $L[$start] + $L[$end] = 0";
            $start = $start + 1;
            $end = $end -1
        } elsif ($L[$i] + $L[$start] + $L[$end] > 0) {
            $end = $end - 1;
        } else {
            $start = $start + 1;
        }
    }
}
