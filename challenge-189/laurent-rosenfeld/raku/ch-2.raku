sub get-degree (@input) {
    my %histogram;
    %histogram{$_}++ for @input;
    return (%histogram.max({$_.value})).key;
}

for <1 3 3 2>, <1 2 1 3>, <4 3 2 1 2> ,
    <1 1 2 3 4>, <2 1 2 1 1> -> @test {
    my $degree = get-degree(@test);
    my $start = @test.first: * == $degree, :k;
    my $end =   @test.first: * == $degree, :k :end;
    say "@test[] \t => @test[$start..$end]";
}
