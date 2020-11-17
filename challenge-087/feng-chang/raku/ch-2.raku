#!/bin/env raku

my @N;
for $*IN.lines -> $line {
    @N.push($line.words».Int);
}

my $LR = 0;
my ($m, $n) = (0, 0);

for 0 ..^ @N.elems - 1 X 0 ..^ @N[0].elems - 1 -> ($i0, $j0) {
    for $i0 + 1 ..^ @N.elems X $j0 + 1 ..^ @N[0].elems -> ($i1, $j1) {
        if @N[$i0..$i1; $j0..$j1].all == 1 {
            my $row = $i1 - $i0 + 1;
            my $col = $j1 - $j0 + 1;
            if $row * $col > $LR {
                $LR = $row * $col;
                $m = $row;
                $n = $col;
            }
        }
    }
}

(1 xx $n).put for ^$m;
