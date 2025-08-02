sub count-equal-div ($divisor where * != 0, @in) {
    my $count = 0;
    for 0..^@in.end -> $i {
        for $i^..@in.end -> $j {
            next if @in[$i] != @in[$j];
            $count++ if $i * $j %% $divisor;
        }
    }
    return $count;
}

my @tests = (2, (3,1,2,2,2,1,3)), (1, (1,2,3));
for @tests -> @test {
    printf "%d - %-15s => ", @test[0], "@test[1]";
    say count-equal-div @test[0], @test[1];
}
