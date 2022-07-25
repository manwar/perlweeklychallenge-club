#!/usr/bin/raku

sub permutation2rank(@args) {
    my @perms = @args.sort.permutations;

    for @perms.kv -> $index, $val {
        if $val ~~ @args {
            return $index;
        }
    }

    return Nil;
}

sub rank2permutation(@args, $rank) {
    return @args.permutations[$rank];
}

sub MAIN(*@args) {
    say permutation2rank([1, 0, 2]);
    say rank2permutation([0, 1, 2], 1);
}