sub lucky-integer (@in) {
    my $count = @in.Bag;
    my @lucky = grep { $_ == $count{$_} }, $count.keys;
    return -1 if @lucky.elems == 0;
    return @lucky.max;
}

my @tests = <2 2 3 4>, <1 2 2 3 3 3>, <1 1 1 3>;
for @tests -> @test {
    printf "%-12s => ", "@test[]";
    say lucky-integer @test;
}
