use v6;

my @tests = [3,  < 1  2  3  4>],
            [6,  < 1  3  5  7>],
            [10, <12 14 16 18>],
            [19, <11 13 15 17>];
for @tests -> $test {
    say $test.gist.fmt("%-20s:\t"), find_insert-pos ($test);
}
sub find_insert-pos ($test) {
    my $target = $test[0];
    my @array = |$test[1];
    for 0..@array.end -> $i {
        return $i if @array[$i] >= $target;
    }
    return @array.end + 1;
}
