use v6;

sub find-diff ($diff,  @array) {
    for (0..@array.end).combinations: 2 -> ($i, $j) {
        say "Indices $j and $i (values: @array[$j], @array[$i])"
            if @array[$j] - @array[$i] == $diff;
    }
}
my ($k, @N);
if @*ARGS.elems > 2 {
    ($k, @N) = @*ARGS;
} else {
    $k = 2;
    @N = 2, 7, 9;
}
find-diff $k, @N;
