sub separate-digits (@ints) {
    return (map { $_.comb }, @ints).flat;
}

for <1 34 5 6>, <1 24 51 60> -> @test {
    printf "%-10s => ", "@test[]";
    say separate-digits @test;
}
