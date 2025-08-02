sub element-digit-sum (@in) {
    return (@in.sum - @in.map({.comb}).flat.sum).abs;
}

my @tests = <1 2 3 45>, <1 12 3>, <1 2 3 4>, <236 416 336 350>;
for @tests -> @test {
    printf "%-20s => ", "@test[]";
    say element-digit-sum @test;
}
