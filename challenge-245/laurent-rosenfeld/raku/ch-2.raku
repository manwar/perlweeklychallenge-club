sub largest-three (@ints) {
    my $max = -1;
    my @sorted = @ints.sort.reverse;
    for @sorted.combinations: 1..@ints.elems -> @seq {
        my $val = [~] @seq;
        next unless $val %% 3;
        $max = $val if $val > $max;
    }
    return $max > 0 ?? $max !! -1;
}

my @tests = <8 1 9>, <8 1 9 3>, <8 6 7 1 0>, (0,);
for @tests -> @test {
    printf "%-10s => ", "@test[]";
    say largest-three @test;
}
