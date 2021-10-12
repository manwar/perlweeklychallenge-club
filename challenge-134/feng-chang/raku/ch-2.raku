#!/bin/env raku

sub MAIN(UInt:D \m, UInt:D \n) {
    my @widths = (1..n)».&{ $_*m }».chars;
    my %terms;

    put 'x'.fmt("%{ m.chars }s"),
        ' |',
        (1..n)».&{ $_.fmt(" %{ @widths[$_-1] }d") }.join;
    put '-' x m.chars,
        '-+',
        '-' x (@widths.sum + n);

    for 1..m -> $row {
        put $row.fmt("%{ m.chars }d"),
            ' |',
            (1..n)».&{ my $i = $_*$row; ++%terms{$i}; $i.fmt(" %{ @widths[$_-1] }d") }.join;
    }

    put "\nDistinct Terms: ", %terms.keys».Int.sort.join(', ');
    put 'Count: ', %terms.keys.elems;
}
