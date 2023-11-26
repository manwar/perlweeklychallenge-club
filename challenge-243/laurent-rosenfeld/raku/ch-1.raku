sub count-reverse-pairs (@in) {
    my $count = 0;
    for 0..^@in.end -> $i {
        for $i+1..@in.end -> $j {
            $count++ if @in[$i] > 2 * @in[$j];
        }
    }
    return $count;
}

for <1 3 2 3 1>, <2 4 3 5 1> -> @test {
    print "@test[] => ";
    say count-reverse-pairs @test;
}
