sub magic-nr (@x, @y) {
    my @in1 = @x.sort;
    my @in2 = @y.sort;
    my @gaps = map {@in1[$_] - @in2[$_]}, 0..@x.end;
    return Nil unless [==] @gaps;
    return @gaps[0].abs;
}

my @tests = (<3 7 5>, <9 5 7>), (<1 2 1>, <5 4 4>),
            ((2,), (5,)), (<3 7 5>, <6 5 7>);
for @tests -> @test {
    printf "%-6s - %-6s => ", "@test[0]", "@test[1]";
    say magic-nr @test[0], @test[1];
}
