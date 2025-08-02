sub sort-letters3 (@let, @w) {
    join "", map { $_[0] }, sort { $_[1] }, zip @let, @w;
}

my @tests = (< R E P L>, <3 2 1 4>),
            (<A U R K>, <2 4 1 3>),
            (<O H Y N P T>, <5 4 2 6 1 3>);
for @tests -> @test {
    printf "%-14s => ", "@test[0]";
    say sort-letters3 @test[0], @test[1];
}
