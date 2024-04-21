sub thirty-three-pct (@in) {
    my $count = @in.elems;
    return Nil if $count == 0;
    my $limit = $count * .33;
    my $histo = @in.Bag;
    my @eligibles = grep { $histo{$_} > $limit }, $histo.keys;
    return @eligibles ?? @eligibles.min !! Nil;
}

my @tests = <1 2 3 3 3 3 4 2>, <1 2>, <1 2 3>,
            <1 2 1 2 1 2 1 2>, <1 2 3 4 1 2 3 4>;
for @tests -> @test {
    printf "%-18s => ", "@test[]";
    say thirty-three-pct @test;
}
