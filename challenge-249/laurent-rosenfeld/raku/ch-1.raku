sub equal-pairs (@in) {
    my @pairs;
    for @in.sort -> $a, $b {
        return "()" unless $a == $b;
        push @pairs, ($a, $b);
    }
    return @pairs;
}

for (3, 2, 3, 2, 2, 2), (1, 2, 3, 4) -> @test {
    printf "%-15s => ", "@test[]";
    say equal-pairs @test;
}
