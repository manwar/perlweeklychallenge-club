#!/bin/env raku

unit sub MAIN(Str:D $f where *.IO.f);

class Cell {
    has $.row;
    has $.col;
    has $.symbol;

    multi method new($row, $col, $symbol) { self.bless(:$row, :$col, :$symbol) }
    multi method WHICH(Cell:D:)           { "Cell|{$!row},{$!col},{$!symbol}" }
}

class Block {
    has %.cells is SetHash;
    has $.symbol;

    multi method new(%cells, $symbol) { self.bless(:%cells, :$symbol) }
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
        if neighbours (elem) @blocks[$i].cells {
            @blocks[$i].cells.set(cell);
            last;
        }
        ++$i;
    }

    my $j = $i + 1;
    while $j < +@blocks {
        if neighbours (elem) @blocks[$j].cells {
            @blocks[$i].cells (+)= @blocks[$j].cells;
            @blocks.splice($j, 1);
        } else {
            ++$j;
        }
    }

    @blocks.push(Block.new((cell).SetHash, symbol)) if $i ≥ +@blocks;
}

put @blocks.map({ .cells.elems }).max;
