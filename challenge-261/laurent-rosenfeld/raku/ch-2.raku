sub multiply-by-two ($start is copy where * != 0, @in) {
    my $bag = @in.Bag;
    $start *= 2 while $bag{$start};
    return $start;
}

my @tests = (3, (5,3,6,1,12)), (1, (1,2,4,3)), (2, (5,6,7));
for @tests -> @test {
    printf "%d - %-15s => ", @test[0], "@test[1]";
    say multiply-by-two @test[0], @test[1];
}
