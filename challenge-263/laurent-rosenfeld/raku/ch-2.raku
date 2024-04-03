sub merge-items (@in1, @in2) {
    my %total;
    for (|@in1, |@in2) -> @items {
        %total{@items[0]} += @items[1];
    }
    return map { ($_, %total{$_} ) }, %total.keys.sort;
}

my @tests = ( ((1,1), (2,1), (3,2)), ((2,2), (1,3)) ),
            ( ((1,2), (2,3), (1,3), (3,2)), ((3,1), (1,3)) ),
            ( ((1,1), (2,2), (3,3)), ((2,3), (2,4)) );
for @tests -> @test {
    printf "%-15s - %-10s => ", "@test[0]", "@test[1]";
    say merge-items @test[0], @test[1];
}
