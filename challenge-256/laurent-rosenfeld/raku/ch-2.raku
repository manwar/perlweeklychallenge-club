sub merge-strings ($str1, $str2) {
    my $res = join "", roundrobin $str1.comb, $str2.comb, :slip;
    return $res;
}

my @tests = <abcd 1234>, <abc 12345>, <abcde 123>;
for @tests -> @test {
    printf "%-12s => ", "@test[]";
    say merge-strings @test[0], @test[1];
}
