#!/bin/env raku

my $shortest-length;
my Array $shortest-path;

sub distance(Array:D $TS, List:D $path) {
    my Array:D $p = [0, |$path, 0];
    my $dist = [+] (^$TS.elems).map({ $TS[$p[$_];$p[$_+1]] });
    if $dist < $shortest-length {
        $shortest-length = $dist;
        $shortest-path   = $p;
    }

    $dist
}

sub MAIN(Str:D $f where *.IO.e) {
    my Array $TS .= new;
    $f.IO.lines.map({ $TS.push($_.words».UInt.Array) });

    $shortest-length = [+] $TS».max;

    put (1..^$TS.elems).permutations.map({ distance($TS, $_) }).min;
    put $shortest-path.gist;
}
