sub zero-sum ($n) {
    my @result;
    for (1..$n*2).pick(($n/2).Int) -> $i {
        append @result, ($i, -$i);
    }
    append @result, 0 unless $n %% 2;
    return @result;
}
for 3, 4, 5, 1 -> $test {
    say "$test => ", zero-sum $test;
}
