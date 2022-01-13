use v6;

sub add-bin ($a, $b) {
    ($a.Str.parse-base(2) + $b.Str.parse-base(2)).base(2);
}
for (11, 1), (101, 1), (100, 11), (1011,11) -> $test {
    say "$test\t=> ", add-bin $test[0], $test[1];
}
