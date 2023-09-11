sub special-comp {
    return $^b <=> $^a if %*histo{$^a} == %*histo{$^b};
    return %*histo{$^a} <=> %*histo{$^b};
}

sub freq-sort (@in) {
    my %*histo;
    %*histo{$_}++ for @in;
    my @sorted = sort &special-comp, %*histo.keys;
    my @result = map { |($_ xx %*histo{$_})}, @sorted;
}

for <1 1 2 2 2 3>, <2 3 1 3 2>,
    (-1,1,-6,4,5,-6,1,4,1) -> @test {
    printf "%-25s => ", "@test[]";
    say freq-sort @test;
}
