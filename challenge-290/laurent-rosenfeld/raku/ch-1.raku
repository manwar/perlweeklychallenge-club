sub double-exists (@in) {
    for @in.combinations: 2 -> $comb {
        return True if $comb[0] == 2 * $comb[1] or
            $comb[1] == 2 * $comb[0];
    }
    False;
}

my @tests = <1 2 3 4>, <6 2 3 3>, <3 1 4 13>, <2 1 4 2>;
for @tests -> @test {
    printf "%-10s => ", "@test[]";
    say double-exists @test;
}
