#!/usr/bin/env raku
use v6.d;

#
# Copyright © 2023 Joelle Maslak
# All Rights Reserved - See License
#

sub MAIN(*@rows) {
    my @a = gather {
        if @rows.elems {
            for @rows<> -> $row {
                take $row.words.map({Int($^a)}).list;
            }
        } else {
            for $*IN.lines() -> $row {
                take $row.words.map({Int($^a)}).list;
            }
        }
    }

    my $row-count = @a.elems();
    my $col-count = @a[0].elems();
    if @a.first( { $^a.elems ≠ $col-count } ) {
        die("All rows must have the same number of elements");
    }

    my @b;
    for 0..^($row-count - 1) -> $i {
        @b.push: [];
        for 0..^($col-count - 1) -> $k {
            @b[*-1].push: [+] cross(($i, $i+1),($k, $k+1)).map( { @a[$^a[0]; $^a[1]] } );
        }
        say join " ", @b[*-1].map: { sprintf("%4d", $^a) };
    }
}

