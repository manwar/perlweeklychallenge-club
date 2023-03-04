sub shortest ($t1, $t2) {
    my $mod = 60 * 12;    # half a day
    my ($h1, $m1) = split /\:/, $t1;
    my ($h2, $m2) = split /\:/, $t2;
    return abs ($m1 - $m2) if $h1 == $h2;
    my $delta = abs(($h1 * 60 + $m1) - ($h2 * 60 + $m2));
    $delta = $mod * 2 - $delta if $delta > $mod;
}

for ("00:00", "23:55", "20:00"),
    ("01:01", "00:50", "00:57"),
    ("10:10", "09:30", "09:00", "09:55") -> @test {
    my $min = Inf;
    for @test.combinations(2) -> @comb {
        my $diff = shortest @comb[0], @comb[1];
        $min = $diff if $diff < $min;
    }
    say "@test[]".fmt("%-25s => "), $min;
}
