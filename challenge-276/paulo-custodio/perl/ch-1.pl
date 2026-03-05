#!/usr/bin/env perl

use Modern::Perl;

say complete_days(@ARGV);

sub complete_days {
    my(@hours) = @_;
    my $pairs = 0;
    for my $i (0 .. $#hours-1) {
        for my $j ($i+1 .. $#hours) {
            $pairs++ if ($hours[$i]+$hours[$j]) % 24 == 0;
        }
    }
    return $pairs;
}
