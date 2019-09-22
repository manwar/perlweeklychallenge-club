#!/usr/bin/env perl6
use v6;

sub MAIN(+@angles) {
    my $x = 0;
    my $y = 0;

    for @angles -> $angle {
        my $rad = ($angle % 360) * π / 180;
        $x += cos($rad);
        $y += sin($rad);
    }

    kif $x ≅ 0 {
        say "No average";
    } else {
        my $deg = atan($y/$x) * 180 / π;
        if $x > 0 and $y > 0 {
            say $deg.fmt("%.2f");
        } elsif $x < 0 and $y > 0 {
            say ($deg + 180).fmt("%.2f");
        } elsif $x < 0 and $y < 0 {
            say ($deg + 180).fmt("%.2f");
        } else {
            my $out = ($deg + 360).fmt("%.2f");
            if $out eq '360.00' {
                say "0.00";
            } else {
                say $out;
            }
        }
    }
}


