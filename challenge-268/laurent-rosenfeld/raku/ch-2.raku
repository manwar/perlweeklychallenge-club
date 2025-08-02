sub number-game (@in) {
    my @result;
    for @in.sort -> $i, $j {
        push @result, $j, $i;
    }
    return @result;
}

my @tests = <2 5 3 4>, <1 1 4 3 6 4 9 6>, <1 2 2 3>;
for @tests -> @test {
    printf "%-16s => ", "@test[]";
    say number-game @test;
}
