sub two-out-of-three (@a) {
    my $histo = BagHash.new: @a[0].unique;
    $histo.add($_) for @a[1].unique, @a[2].unique;
    return sort grep { $histo{$_} >= 2 }, $histo.keys;
}
for ( (1, 1, 2, 4), (2, 4), (4,) ),
    ( (4, 1), (2, 4), (1, 2) ) -> @test {
    printf "%-22s => ", @test.gist;
    say two-out-of-three (@test);
}
