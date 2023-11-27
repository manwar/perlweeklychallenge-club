sub count-smaller (@in) {
    my @result;
    my @sorted = @in.sort;
    for @in -> $i {
        my $count = 0;
        for @sorted -> $j {
            last if $j >= $i;
            $count++;
        }
        push @result, $count;
    }
    return @result;
}

for <8 1 2 2 3>, <6 5 4 8>, <2 2 2> -> @test {
    printf "%-12s => ", "@test[]";
    say "" ~ count-smaller @test;
}
