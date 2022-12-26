sub find-ranges (@in) {
    my ($start, $curr);
    my @result;
    $start = $curr = @in[0];
    for 1..@in.end -> $i {
        next if @in[$i] == $start;
        if @in[$i] == $curr + 1 {
            $curr = @in[$i];
        } else {
            push @result, "[$start $curr]"
                if $curr - $start > 0;
            $start = @in[$i];
            $curr = $start;
        }
    }
    push @result, "[$start $curr]" if $curr > $start;
    return @result.elems > 0 ?? @result !! "[]";
}
for <1 3 4 5 7>, <1 2 3 6 7 9>, <0 1 2 4 5 6 8 9>,
    <1 3 4 6 7 11 12 13>, <1 3 4 5 7 9>, <1 3 5> -> @test {
    printf "%-20s => %s\n", ~@test, ~find-ranges @test;
}
