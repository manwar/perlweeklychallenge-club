sub find-largest (@in) {
    my @sorted = @in.sort.reverse;
    return @sorted if @sorted[*-1] %% 2;
    for (0..@in.end).reverse -> $i {
        # swap smallest even digit with last digit
        if @sorted[$i] %% 2 {
            @sorted[$i, *-1] = @sorted[*-1, $i];
            return @sorted;
        }
    }
    return (); # Failed, no even digit
}
for <1 0 2 6>, <1 3 2 6>,
    <1 3 5 7>, <1 4 2 8> -> @test {
    my @result = find-largest @test;
    print @test, ": ";
    if @result.elems > 0 {
        say "Solution: ", @result.join('');
    } else {
        say "No solution";
    }
}
