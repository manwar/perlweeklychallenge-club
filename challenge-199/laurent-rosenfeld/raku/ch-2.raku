sub count_good_triplets (@in, @xyz) {
    my $count = 0;
    my ($x, $y, $z) = @xyz;
    for 0..@in.end-2 -> $i {
        for $i+1..^@in.end -> $j {
            next if abs(@in[$i] - @in[$j]) > $x;
            for $j+1..@in.end -> $k {
                $count++ if abs(@in[$j] - @in[$k]) <= $y
                    && abs(@in[$i] - @in[$k]) <= $z;
            }
        }
    }
    return $count;
}

for ( <3 0 1 1 9 7>,  <7 2 3> ),
    ( <1 1 2 2 3>, <0 0 1> ),
    ( <1 1 2 2 3>, <1 1 2> ) -> @test {

    say sprintf "%-15s - xyz = %-10s => %d",
                "@test[0]", "@test[1]",
                count_good_triplets @test[0], @test[1];
}
