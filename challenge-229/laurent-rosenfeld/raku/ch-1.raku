sub unsorted (@in) {
    my $count = 0;
    for @in -> $str {
        my @let = $str.comb.sort;
        $count++ if $str ne
            (@let.join(""), @let.reverse.join("")).any;
    }
    return $count;
}
for <abc bce cae>, <yxz cba mon> -> @test {
    printf "%-12s => ", "@test[]";
    say unsorted @test;
}
