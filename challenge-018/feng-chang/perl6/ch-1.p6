#!/bin/env perl6

use Test;
plan 3;

# Longest Common String
sub infix:<LCS>(Str:D $s, Str:D $t --> Str) {
    my Str @S = $s.comb;
    my Str @T = $t.comb;
    my UInt @L[$s.chars, $t.chars];
    my UInt $z = 0;
    my Str @ret = ();

    for 0..^$s.chars -> $i {
        for 0..^$t.chars -> $j {
            if @S[$i] eq @T[$j] {
                if $i == 0 or $j == 0 {
                    @L[$i; $j] = 1;
                } else {
                    @L[$i; $j] = @L[$i-1; $j-1] + 1;
                }

                if @L[$i; $j] > $z {
                    $z = @L[$i; $j];
                    @ret = @S[$i-$z+1 .. $i].join;
                } elsif @L[$i; $j] == $z {
                    @ret.push(@S[$i-$z+1 .. $i].join);
                }
            } else {
                @L[$i; $j] = 0;
            }
        }
    }

    return @ret.join;
}

is 'BABC', 'ABABC' LCS 'BABCA', "LCS('ABABC', 'BABCA') => 'BABC'";
is 'ABC',  'BABCA' LCS 'ABCBA', "LCS('BABCA', 'ABCBA') => 'ABC'";
is 'ABC',  ([LCS] <ABABC BABCA ABCBA>.flat), "LCS('ABABC', 'BABCA', 'ABCBA') => 'ABC'";
