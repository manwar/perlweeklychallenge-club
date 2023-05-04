#!/bin/env raku

unit sub MAIN(Str:D $f where *.IO.e = 'input.txt');

my @N = $f.IO.lines.map({ .words».Int.Array }).Array;
my $rows = +@N;
my $cols = +@N[0];

my %groups;
for ^$rows -> $r {
    for ^$cols -> $c {
        %groups{$c-$r}.push([$r, $c]);
    }
}

put +so %groups.keys.map({ [==] %groups{$_}.map({ @N[.[0];.[1]] }) }).all;
