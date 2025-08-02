#!/bin/env raku

unit sub MAIN(Str:D $source, Str:D $target);

put so (^$source.chars).combinations(2).map({ $source.&xchg($_) }).any eq $target;

my method xchg(Str:D $s : @swp --> Str:D) {
    with $s.comb -> @s is copy {
        @s[@swp] = @s[@swp.reverse];
        @s.join
    }
}
