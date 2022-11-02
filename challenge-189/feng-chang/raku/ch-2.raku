#!/bin/env raku

sub degree(@N is copy --> UInt:D) {
    my $d = 0;

    while @N {
        my $cnt = @N.grep(* == @N[0]).elems;
        $d = $cnt if $cnt > $d;
        @N .= grep(* != @N[0]);
    }

    $d
}

unit sub MAIN(*@n);

my $d = degree(@n);
my @candidates = (^@n.elems X ^@n.elems).grep({.[1] ≥ .[0]}).grep({ $d == degree(@n[.minmax]) });
my $min-val = @candidates.map({ .[1] - .[0] }).min;
put @n[@candidates.grep({ $min-val == .[1]-.[0] }).first.minmax];
