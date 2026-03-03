#!/usr/bin/env perl

use Modern::Perl;

sub double_exist {
    my(@n) = @_;
    for my $i (0..$#n-1) {
        for my $j ($i+1..$#n) {
            if ($n[$i]==2*$n[$j] || $n[$j]==2*$n[$i]) {
                return 1;
            }
        }
    }
    return 0;
}

say double_exist(@ARGV) ? "true" : "false";
