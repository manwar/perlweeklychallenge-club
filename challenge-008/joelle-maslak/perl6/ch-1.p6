#!/usr/bin/env perl6
use v6.d;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

sub MAIN(UInt:D $max = 5) {

    if $max > 7 {
        say "More than 7 perfect numbers may take too long to calculate";
    }

    my @vals = lazy gather {
        loop {
            state $p = 1;
            $p++;

            my $possible = (2**($p-1))*((2**$p)-1);
            take $possible if ([+] factors($possible)[0..*-2]) == $possible;
        }
    }

    say @vals[^$max];
}

sub factors($i) {
    if ($i == 0) { my @zero = 0; return @zero; }

    my uint $sqrt = sqrt($i).Int;

    return squish (0..$sqrt).grep( $i %% * ).map( { $^a, $i div $^a } ).flat.sort;
}

