sub count-even-digits-ints (@in) {
    (grep { .chars %% 2 }, @in).elems;
}

my @tests = <10 1 111 24 1000>, <111 1 11111>, <2 8 1024 256>;
for @tests -> @test {
    printf "%-20s => ", "@test[]";
    say count-even-digits-ints @test;
}
