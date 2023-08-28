sub empty-array (@in is copy) {
    my $count = 0;
    loop {
        my $val = shift @in;
        push @in, $val if $val > @in.any;
        $count++;
        last unless @in;
    }
    return $count;
}

for <3 4 2>, <1 2 3>, <3 2 1>, <4 7 2 9 1> -> @test {
    printf "%-10s => ", "@test[]";
    say empty-array @test;
}
