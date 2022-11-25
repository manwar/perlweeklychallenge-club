sub flip (Int $n) {
    my $bin = $n.base(2);
    $bin ~~ tr/10/01/;
    return $bin.parse-base(2);
}

for 5, 4, 6 -> $test {
    say "$test => ", flip($test);
}
