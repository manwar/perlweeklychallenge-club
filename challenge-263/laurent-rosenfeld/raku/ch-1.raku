sub find-index ($target, @in) {
    my @sorted = @in.sort;
    my @out = grep {@sorted[$_] == $target}, 0..@sorted.end;
    return @out;
}

my @tests = (2, (1, 5, 3, 2, 4, 2)),
            (6, (1, 2, 4, 3, 5)),
            (4, (5, 3, 2, 4, 2, 1));
for @tests -> @test {
    printf "%d - %-15s => ", @test[0], "@test[1]";
    say find-index @test[0], @test[1];
}
