sub merge_items {
    my %total;
    for my $in (@_) {
        for my $items (@$in) {
            $total{$items->[0]} += $items->[1];
        }
    }
    return map { "[ $_  $total{$_} ] " } sort keys %total;
}

my @tests = ( [ [[1,1], [2,1], [3,2]], [[2,2], [1,3]] ],
              [ [[1,2], [2,3], [1,3], [3,2]], [[3,1], [1,3]] ],
              [ [[1,1], [2,2], [3,3]], [[2,3], [2,4]] ] );
for my $test (@tests) {
    printf "%-3s %-3s => ", "[$test->[0][0][0]", "$test->[0][0][1]] ...";
    say merge_items  @$test[0], @$test[1];
}
