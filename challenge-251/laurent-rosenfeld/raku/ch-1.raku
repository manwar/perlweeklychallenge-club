sub concat-vals (@in is copy) {
    my $concat;
    while @in.elems > 1 {
        $concat += @in.shift ~ @in.pop;
    }
    $concat += shift @in if @in.elems > 0; # last item if any
    return $concat;
}

for <6 12 25 1>, <10 7 31 5 2 2>, <1 2 10> -> @test {
    printf "%-15s => ", "@test[]";
    say concat-vals @test;
}
