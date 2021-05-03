#!/usr/bin/raku

sub MAIN(
    Str $filename
) {
    my @table;
    for $filename.IO.lines -> $line {
        @table.push($line.split(q{,}));
    }

    (0 ..^ @table[0].elems).map({ @table[*;$_]; }).map({ $_.join(q{,}).say; });
}