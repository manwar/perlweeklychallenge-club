sub max-pos-neg (@in) {
    (@in.grep({$_ > 0}).elems, @in.grep({$_ < 0}).elems).max;
}

my @tests = <-3 1 2 -1 3 -2 4>, <-1 -2 -3 1>, <1 2>;
for @tests -> @test {
    printf "%-20s => ", "@test[]";
    say max-pos-neg @test;
}
