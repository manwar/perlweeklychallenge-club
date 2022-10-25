sub is-valid-triplet ($a, $b, $c) {
    return False if $c >= $a + $b;
    return False if $b >= $a + $c;
    return False if $a >= $b + $c;
    return True;
}
for <1 2 3 2>, <1 3 2>, <1 1 2 3>, <2 4 3> -> @test {
    my @valid;
    for @test.sort.reverse.combinations: 3 -> @triplet {
        push @valid, @triplet if is-valid-triplet | @triplet;
    }
    say @test, " => ", @valid.elems > 0 ?? @valid[0] !! "()";
}
