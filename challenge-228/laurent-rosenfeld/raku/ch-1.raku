sub unique-sum (@in) {
    my $histo = @in.Bag;    # histogram
    my @unique = grep { $histo{$_} == 1 }, $histo.keys;
    return [+] @unique;
}

for (2, 1, 3, 2), (1, 1, 1, 1), (2, 1, 3, 4) -> @test {
    printf "%-10s => ", "@test[]";
    say unique-sum @test;
}
