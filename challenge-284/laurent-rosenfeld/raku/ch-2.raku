sub relative-sort (@in1, @in2) {
    my @result;
    my $to-be-sorted = @in1.BagHash;
    for @in2 -> $i {
        if $to-be-sorted{$i}:exists {
            append @result, $i xx $to-be-sorted{$i};
            $to-be-sorted{$i} = 0;
        }
    }
    append @result, (map { $_ xx $to-be-sorted{$_}}, $to-be-sorted.keys).sort;
    return "@result[]";
}

my @tests = ((2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5), (2, 1, 4, 3, 5, 6)),
            ((3, 3, 4, 6, 2, 4, 2, 1, 3), (1, 3, 2)),
            ((3, 0, 5, 0, 2, 1, 4, 1, 1), (1, 0, 3, 2));
for @tests -> @test {
    printf "%-15s => ", "@test[1]";
    say relative-sort @test[0], @test[1];
}
