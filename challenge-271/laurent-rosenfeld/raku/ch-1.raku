sub maximum-ones (@mat) {
    my $max = 0;
    my $max-i;
    for 0..@mat.end -> $i {
        my $sum = @mat[$i].sum;
        if $sum > $max {
            $max = $sum;
            $max-i = $i;
        }
    }
    return $max-i + 1;
}

my @tests = [ [0, 1], [1, 0] ],
            [ [0, 0, 0], [1, 0, 1] ],
            [ [0, 0], [1, 1], [0, 0] ];
for @tests -> @test {
    printf "%-20s => ", @test.gist;
    say maximum-ones @test;
}
