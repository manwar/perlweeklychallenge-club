sub farey (Int $n) {
    my @out;
    for 1..$n -> $den {
        for 0..$den -> $num {
            push @out, $num/$den;
        }
    }
    return @out.Set;
}
for 3..7 -> $test {
    say "$test -> ", map { .numerator ~ "/" ~ .denominator },  sort farey($test).keys;
}
