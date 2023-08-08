#!/bin/env raku

unit sub MAIN(Str:D $s);

my @Tree;
my UInt $depth = 0;
$s.split('|').map({ @Tree[$depth++] = .words.map({ $_ eq '*' ?? Nil !! $_.Int }).Array });
@Tree = [] if +@Tree[0] == 0;

my $min-depth = +@Tree;
for ^@Tree -> $row {
    for ^@Tree[$row] -> $col {
        next without @Tree[$row;$col];
        with @Tree[$row+1] {
            next with @Tree[$row+1;2*$col];
            next with @Tree[$row+1;2*$col+1];
            $min-depth = $row + 1 if $row + 1 < $min-depth;
        }
    }
}
put $min-depth;
