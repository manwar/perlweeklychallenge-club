#!/bin/env raku

sub MAIN(UInt:D \m, UInt:D \n) {
    my @widths = (1..n)».&{ $_*m }».chars;

    put 'x'.fmt("%{ m.chars }s"),
        ' |',
        (1..n)».&{ $_.fmt(" %{ @widths[$_-1] }d") }.join;
    put '-' x m.chars,
        '-+', 
        (1..n)».&{ '-' x (@widths[$_-1] + 1) }.join;

    for 1..m -> $row {
        put $row.fmt("%{ m.chars }d"),
            ' |',
            (1..n)».&{ ($_*$row).fmt(" %{ @widths[$_-1] }d") }.join;
    }
}
