sub odd-char ($s, $t) {
    return ~ ($t.comb.Bag (-) $s.comb.Bag);
}

for <Perl Preel>, <Weekly Weeakly>, <Box Boxy> -> @test {
    printf "%-8s %-8s => ", @test;
    say odd-char @test[0], @test[1];
}
