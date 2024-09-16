sub find-unique-number (@in) {
    my $count = @in.Bag;
    return (grep { $count{$_ } == 1}, $count.keys).first;
}

my @tests = <3 3 1>, <3 2 4 2 4>, (1,), <4 3 1 1 1 4>;
for @tests -> @test {
    printf "%-12s => ", "@test[]";
    say find-unique-number @test;
}
