sub flip {
    my $bin = sprintf "%b", shift;
    $bin =~ tr/10/01/;
    return oct("0b" . $bin);
}

for my $test (5, 4, 6) {
    say "$test => ", flip($test);
}
