sub special-numbers (@in) {
    my $n = @in.elems;
    my $sq-sum = 0;
    for 0..@in.end -> $i {
        $sq-sum += @in[$i]² if $n %% ($i+1);
    }
    return $sq-sum;
}

for <1 2 3 4>, <2 7 1 19 18 3> -> @test {
    printf "%-15s => ", "@test[]";
    say special-numbers @test;
}
