sub is-squareful (@in) {
    for @in.rotor(2 => -1) -> @list {
        my $sum = [+] @list;
        return False if ($sum.sqrt.Int)² != $sum;
    }
    return True;
}
sub find-squareful (@in) {
    my $result = SetHash.new;
    for @in.permutations -> $perm {
        $result{"($perm)"}++ if is-squareful $perm;
    }
    return join ", ", $result.keys;
}
for <1 17 8>, <17 1 8>, <2 2 2> -> @test {
    say @test, " => ",  find-squareful @test;
}
