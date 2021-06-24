use v6;

for 1..12 -> $test {
    say "$test -> ", + ($test.base(2) eq $test.base(2).flip);
}
