#!/bin/env raku

sub binary-search(@a, Int:D $start, Int:D $end, Int:D $n) {
    my $middle = ($start + $end) div 2;
    do given @a[$middle] {
        when $_ == $n { 1 }
        when $start == $end { 0 }
        when $_ >  $n { binary-search(@a, $start,      $middle - 1, $n) }
        default       { binary-search(@a, $middle + 1, $end,        $n) }
    }
}

sub MAIN(
    Int:D $n,
    Str:D $f where *.IO.f = 'ch-1.txt'
) {
    my @a = $f.IO.words;
    put binary-search(@a, 0, @a.elems - 1, $n);
}
