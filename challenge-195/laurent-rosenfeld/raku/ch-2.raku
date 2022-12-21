sub find-frequent-int (@in) {
    my %histo = map { $_ => ++%histo{$_} },
                grep { $_ %% 2 }, @in;
    return -1 if %histo.elems < 1;
    return ( sort { %histo{$^b} <=> %histo{$^a}
                  || $^a <=> $^b },
          %histo.keys ).first;
}
for < 1 1 2 6 2>, <1 3 5 7>, <6 4 4 6 1>, < 8 4 8 6 4 6>,
    < 8 4 8 6 4 6 8>, < 6 4 8 6 4 6 8> -> @test {
    say @test, " => ", find-frequent-int @test;
}
