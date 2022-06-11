#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtabs
use v6.d;

my $n = 7;

say "Input: \$n = $n";

my @farey
    = sort { $^a <=> $^b }, gather
        { for 1 .. $n -> $de {
                for 0 .. $de -> $nu {
                    take $nu/$de;
                }
            }
        }.unique;

for @farey -> $f is rw {
    $f = $f.numerator ~ '/' ~ $f.denominator;
}

say "Output = @farey.join(', ').";
