sub lucky-number (@in) {
    ROW-LABEL:
    for 0..@in.end -> $row {
        my $min_i = min(0..@in[$row].end, :by( {@in[$row][$_] }));
        my $min_val = @in[$row][$min_i];
        for 0..@in.end -> $i {
            next ROW-LABEL if @in[$i][$min_i] > $min_val;
        }
        return $min_val;
    }
    return -1
}


for ( <3 7 8>, <9 11 13>, <15 16 17>),
    ( <1 10 4 2>, <9 3 8 7>, <15 16 17 12>),
    ( <7 8>, <1 2> ) -> @test {

    printf "%-40s => ", @test.gist;
    say lucky-number @test;
}
