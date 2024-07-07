sub max-frequency (@in) {
    my $frequencies = @in.Bag;
    my $max = $frequencies.values.max;
    my $count = 0;
    for $frequencies.keys -> $i {
        $count += $max if $frequencies{$i} == $max;
    }
    return $count;
}

my @tests = (1, 2, 2, 4, 1, 5), (1, 2, 3, 4, 5);
for @tests -> @test {
    printf "%-15s => ", "@test[]";
    say max-frequency @test;
}
