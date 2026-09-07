#!/bin/env raku

unit sub MAIN(Str:D $rat1, Str:D $rat2);

sub rat-to-string(Str:D $rat --> Str:D) {
    my $r = '';
    with $rat.match(/^ (\d+ '.' \d*) ['(' (\d+) ')']? $/) {
        $r = $0.Str;
        with $1 {
            $r ~= $1 while $r.chars < 42;
        }
    }
    die unless $r;

    $r
}

put +rat-to-string($rat1) =~= +rat-to-string($rat2);
