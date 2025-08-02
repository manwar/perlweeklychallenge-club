sub double_exists {
    for my $i (0..$#_) {
        for my $j (0..$#_) {
            return "True" if $_[$i] == 2 * $_[$j];
        }
    }
    return "False";
}

my @tests = ( [1, 2, 3, 4], [6, 2, 3, 3 ],
              [3, 1, 4, 13], [2, 1, 4, 2] );
for my $test (@tests) {
    printf "%-10s => ", "@$test";
    say double_exists @$test;
}
