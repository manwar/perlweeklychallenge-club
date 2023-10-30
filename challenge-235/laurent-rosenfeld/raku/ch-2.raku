sub duplicate-zeros (@in) {
    my @result = map { $_ == 0 ?? |(0, 0) !! $_ }, @in;
    return @result[0..@in.end];
}

for <1 0 2 3 0 4 5 0>,  <1 2 3>, <0 3 0 4 5> -> @test {
    printf "%-18s => ", "@test[]";
    say duplicate-zeros @test;
}
