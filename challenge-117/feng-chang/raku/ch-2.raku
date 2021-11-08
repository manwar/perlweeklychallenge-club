#!/bin/env raku

my Bool $not-first = False;

sub travel(UInt:D $row, UInt:D $col, Str:D $path, UInt:D $target-row, UInt:D $target-col) {
    if $row == $target-row and $col == $target-col {
        if $not-first {
            print ', ';
        } else {
            $not-first = True;
        }
        print $path;
        return;
    }

    # try 'R'
    travel($row + 1, $col + 1, $path ~ 'R', $target-row, $target-col) if $row < $target-row and $col < $target-col;

    # try 'H'
    travel($row, $col + 1, $path ~ 'H', $target-row, $target-col) if $col < $row;

    # try 'L'
    travel($row + 1, $col, $path ~ 'L', $target-row, $target-col) if $row < $target-row;
}

sub MAIN(UInt:D $n = 10) {
    travel(0, 0, '', $n, $n);
    put '';
}
