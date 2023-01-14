sub count_good_pairs (@in) {
    my $cnt = 0;
    for 0..^@in.end -> $i {
        $cnt++ if @in[$i] == @in[$_] for $i+1..@in.end;
    }
    return $cnt;
}

for <1 2 3 1 1 3>,  <1 2 3>,  <1 1 1 1>,
    <1 2 3 1 2 3>,  <4 3 2 3 2 1> -> @test {
    say (~@test).fmt("%-15s => "), count_good_pairs @test;
}
