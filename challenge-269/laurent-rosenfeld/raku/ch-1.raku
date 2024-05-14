sub bitwise-or (@in) {
    my @evens = grep { $_ %% 2 }, @in;
    return @evens.elems >= 2 ?? True !! False;
}

my @tests = (1, 2, 3, 4, 5), (2, 3, 8, 16), (1, 2, 5, 7, 9);
for @tests -> @test {
    printf "%-12s => ", "@test[]";
    say bitwise-or @test;
}
