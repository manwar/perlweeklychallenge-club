#!/bin/env raku

my Int $M = prompt 'm: ';
my Int $N = prompt 'n: ';

my @a;
for $*IN.lines() -> $line {
    @a.append($line.comb(/(\d+)/));
    last if @a.elems ≥ $M * $N;
}

my Int @Mat[$M;$N];
for ^$M -> Int $i {
    for ^$N -> Int $j {
        @Mat[$i;$j] = @a.shift.Int;
    }
}

my @Path[$M;$N];
@Path[0;0] = [@Mat[0;0]];

for 1 .. $M + $N - 2 -> Int $s {
    for (0, $s - $N + 1).max .. ($s, $M - 1).min -> Int $i {
        my Int $j = $s - $i;

        ($i > 0 ?? [+] @Path[$i-1;$j] !! ∞) < ($j > 0 ?? [+] @Path[$i;$j-1] !! ∞) ??
            (@Path[$i;$j] = @Path[$i-1;$j].clone) !!
            (@Path[$i;$j] = @Path[$i;$j-1].clone);

        @Path[$i;$j].append(@Mat[$i;$j]);
    }
}

say "{ [+] @Path[$M-1;$N-1] } ({ @Path[$M-1;$N-1].join(' -> ') })";
