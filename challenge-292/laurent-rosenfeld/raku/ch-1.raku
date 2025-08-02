sub twice-larger (@in) {d for an extra loop.
    my ($max-i, $largest) = @in.max(:kv);
    for @in -> $i {
        next if $i == $largest;
        return -1 if 2 * $i > $largest;
    }
    return $max-i;
}
for (2, 4, 1, 0), (1, 2, 3, 4), (4, 3, 5, 12, 2) -> @test {
    printf "%-12s => ", "@test[]";
    say twice-larger @test;
}
