#!/usr/bin/env raku
use v6;

# run <script> <nr of cities>

sub mkRMat($n) {
    [1..$n].map(-> $i { [1..$n].map(-> $j {($i==$j) ?? (0) !! (9.rand.Int+1)}).Array }).Array
}

sub sayMat(@m) {
    for (@m) {.say}
}

sub pathCost(@path,@mat) {
    return (0..^@path.elems).map({ @mat.[@path.[$_]].[@path.[($_+1)% @path.elems]] }).sum
}

my @mat = mkRMat(@*ARGS[0].Int);

say "Your matrix:";
sayMat(@mat);

my @sol = (0..^@*ARGS[0].Int).permutations.min(-> @p { pathCost(@p,@mat) }).Array;
say "Optimal cost: {pathCost(@sol,@mat)}";
say "Optimal Path: {@sol} @sol[0]";
