use v6;

my @tests = [5, 2, 1, 4, 3], [2, 1, 4, 3];
for @tests -> @array {
    my @result;
    @result[0] = [*] @array[1..@array.end];
    for 1..@array.end -> $i {
        @result[$i] = ([*] @array[0..$i-1]) * [*] (@array[$i+1..@array.end]);
    }
    say "Input array: ", @array;
    say "Result: ", @result;
}
