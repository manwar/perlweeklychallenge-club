#!/usr/bin/perl6

my ($topguest, $topshare) = (1 .. 100)
    .map({
        state $pie = 100.0;
        my $share = $pie * ($_ * 0.01);
        $pie -= $share;
        $_ => $share;
    })
    .max( *.value )
    .kv;

say "Guest $topguest gets ", sprintf("%0.2f", $topshare), '% of the pie.';
