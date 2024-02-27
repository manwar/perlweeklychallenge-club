sub count-smaller (@in) {
    my @result;
    for @in -> $i {
        my $count = 0;
        for @in -> $j {
            $count++ if $j < $i;
        }
        push @result, $count;
    }
    return @result;
}

my @tests = <5 2 1 6>, <1 2 0 3>, <0 1>, <9 4 9 2>;
for @tests -> @test {
    printf "%-12s => ", "@test[]";
    say count-smaller @test;
}
