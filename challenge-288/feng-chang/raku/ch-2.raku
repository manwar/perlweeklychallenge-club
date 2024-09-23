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
    my \cell = Cell.new(row, col, symbol);
    my \neighbours = Cell.new(row-1,col,symbol) | Cell.new(row+1,col,symbol) |
                     Cell.new(row,col-1,symbol) | Cell.new(row,col+1,symbol);

    my $i = 0;
    while $i < +@blocks {
        if neighbours (elem) @blocks[$i] {
            @blocks[$i].set(cell);
            last;
        }
        ++$i;
    }

    my $j = $i + 1;
    while $j < +@blocks {
        if neighbours (elem) @blocks[$j] {
            @blocks[$i] (|)= @blocks[$j];
            @blocks.splice($j, 1);
        } else {
            ++$j;
        }
    }

    @blocks.push(cell.SetHash) if $i ≥ +@blocks;
}

put @blocks».elems.max;
