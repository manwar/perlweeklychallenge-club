sub digit-count-value (@in) {
    my %count = @in.Bag;
    for 0..@in.end -> $i {
        return False if %count{$i}:exists and
            @in[$i] != %count{$i};
    }
    return True;
}

my @tests = <1 2 1 0>, <0 3 0>;
for @tests -> @test {
    printf "%-8s => ", "@test[]";
    say digit-count-value @test;
}
