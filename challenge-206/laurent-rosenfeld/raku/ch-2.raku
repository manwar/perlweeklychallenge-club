sub pairings (@in) {
    my $max = - Inf;
    my @perms = @in.permutations;
    for @perms -> $perm {
        for $perm.rotor(2).combinations(2) -> $comb {
            my $sum = $comb[0].min + $comb[1].min;
            $max = $sum if $sum > $max
        }
    }
    return $max;
}
for <1 2 3 4>, <6 5 4 3 2 1>, <0 2 1 3> -> @test {
    say "@test[]".fmt("%-15s => "), pairings @test;
}
