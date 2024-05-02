sub product-sign (@in) {
    my $result = 1;
    for @in -> $i {
        $result *= $i cmp 0;
    }
    return $result;
}
my @tests = <-1 -2 -3 -4 3 2 1>, <1 2 0 -2 -1>, <-1 -1 1 -1 2>;
for @tests -> @test {
    printf "%-18s => ", "@test[]";
    say product-sign @test;
}
