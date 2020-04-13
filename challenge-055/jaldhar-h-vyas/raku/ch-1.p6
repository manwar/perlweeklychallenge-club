#!/usr/bin/perl6

multi sub MAIN(Str $binary where { /^ [0 || 1]+ $/ }) {
    my %lengths;

    for 0 ..^ $binary.chars -> $l {
        for 0 ..^ $binary.chars -> $r {
            my @digits = $binary.comb;
            for $l .. $r -> $i {
                @digits[$i]  = (@digits[$i] == '0') ?? '1' !! '0';
            }

            my $ones = (@digits.grep(1)).elems;
            if $ones {
                %lengths{$ones}.push([$l, $r]);
            }
        }
    }

    my $max = (%lengths.keys.sort({ $^b <=> $^a}))[0];
    if ($max) {
        for %lengths{$max}.Array -> $pair {
            say '(', $pair.join(q{,}), ')';
        }
    }
}