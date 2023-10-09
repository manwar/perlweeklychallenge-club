sub running-sum (@in) {
    return [\+] @in;
}

my @tests = <1 2 3 4 5>, <1 1 1 1 1>, <0 -1 1 2>;
for @tests -> @test {
    printf "%-15s => ", "@test[]";
    say join ", ", running-sum @test;
}
