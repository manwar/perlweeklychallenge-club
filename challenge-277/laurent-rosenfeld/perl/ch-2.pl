sub strong_pairs {
    my %input = map { $_ => 1 } @_; # remove duplicates
    my @in = keys %input;
    my $count = 0;
    for my $i (0..$#in) {
        for my $j ($i+1..$#in) {
            my $min = $in[$i] < $in[$j] ? $i : $j;
            $count++ if 0 < abs($in[$i] - $in[$j]) and
                abs($in[$i] - $in[$j]) < $in[$min];
        }
    }
    return $count;
}

my @tests = ([1, 2, 3, 4, 5], [5, 7, 1, 7]);
for my $test (@tests) {
    printf "%-10s => ", "@$test";
    say strong_pairs @$test;
}
