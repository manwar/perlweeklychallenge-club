#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

multi sub MAIN(UInt:D $digits where * == 0) { return; }
multi sub MAIN(UInt:D $digits where * == 1) { say "2"; return; }
multi sub MAIN(UInt:D $digits = 10) {
    return unless $digits;

    my FatRat $limit = FatRat.new(1, 10**$digits);

    my FatRat $e = FatRat.new(2);
    my $current  = 1;
    my $denom    = 1;

    my $chkdigits = $digits;
    repeat {
        $current++;
        $denom *= $current;

        $e += FatRat.new(1, $denom);

        if $denom.chars >= ($chkdigits + 3) {    # 2 should be enough, but we'll be safe
            if $e.substr(0, $chkdigits+2) ~~ / <[4 9]> $/ {
                $chkdigits++;
            }
        }
    } while $denom.chars < $chkdigits+3;

    $e += FatRat.new(5, (10**$digits+1) );
    say $e.substr(0, $digits+1);
    return;
}


