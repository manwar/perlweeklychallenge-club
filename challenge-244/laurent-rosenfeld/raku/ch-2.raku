sub group-hero (@in) {
    my $sum = 0;
    for @in.combinations: 1..@in.elems -> @comb {
        $sum += @comb.max² * @comb.min;
    }
    return $sum;
}

for <2 1 4>, <4 1 5 2> -> @test {
    printf "%-10s => ", "@test[]";
    say group-hero @test;
}
