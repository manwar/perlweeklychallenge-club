sub three-odd (@in) {
    my $count = 0;
    for @in -> $n {
        if $n %% 2 {        # Even
            $count = 0;
        } else {            # Odd
            $count++;
        }
        return 1 if $count >= 3;
    }
    return 0;
}

for <1 5 3 6>, <2 6 3 5>, <1 2 3 4>, <2 3 5 7> -> @test {
    say "@test[] => ", three-odd @test;
}
