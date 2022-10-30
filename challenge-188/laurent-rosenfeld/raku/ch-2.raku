sub to-zero ($x, $y) {
    return $x >= $y ?? ($x - $y, $y) !! ($x, $y - $x);
}

for <5 4>, <4 6>, <2 5>, <3 1>, <7 4>, <9 1> -> @test {
    my ($x, $y) = @test;
    my $count = 0;
    while ($x and $y ) {
        ($x, $y) = to-zero $x, $y;
        $count++;
    }
    say "@test[] -> $count";
}
