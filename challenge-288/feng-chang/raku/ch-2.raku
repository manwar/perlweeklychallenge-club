#!/bin/env raku

unit sub MAIN(Str:D $f where *.IO.f);

class Cell {
    has $.row;
    has $.col;
    has $.symbol;

    multi method new($row, $col, $symbol) { self.bless(:$row, :$col, :$symbol) }
    multi method WHICH(Cell:D:)           { "Cell|{$!row},{$!col},{$!symbol}" }
}

my @M = $f.IO.lines.map({ .comb.Array });
my @blocks;

for ^+@M X ^+@M[0] -> (\row, \col) {
    my \symbol = @M[row;col];
    @blocks.unshift(Cell.new(row, col, symbol).SetHash);
    my $i = 1;
    while $i < +@blocks {
        if Cell.new(row-1,col,symbol) | Cell.new(row+1,col,symbol) |
           Cell.new(row,col-1,symbol) | Cell.new(row,col+1,symbol)   (elem) @blocks[$i] {
            @blocks[0] (|)= @blocks[$i];
            @blocks.splice($i, 1);
        } else {
            ++$i;
        }
    }
}

put @blocks».elems.max;
