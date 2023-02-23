sub largest-xor (@in) {
    my $max = 0;
    my $max-i;
    for @in.combinations(2) -> $i {
        my $xor = $i[0] +^ $i[1];   # bitwise xor
        $max = $xor and $max-i = $i if $xor > $max
    }
    return "$max-i -- $max";
}

for (1,2,3,4,5,6,7), (2,4,1,3), (10,5,7,12,8) -> @test {
  say (~@test).fmt("%-15s => "), largest-xor @test;
}
