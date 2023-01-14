sub count_good_triplets {
    my @in = @{$_[0]};
    my ($x, $y, $z) = @{$_[1]};
    my $count = 0;
    for my $i (0..$#in-2) {
        for my $j ($i+1..$#in-1) {
            # short-cut the $k loop if $i $j not good
            next if abs($in[$i] - $in[$j]) > $x;
            for my $k ($j+1..$#in) {
                $count++ if abs($in[$j] - $in[$k]) <= $y
                    and abs($in[$i] - $in[$k]) <= $z;
            }
        }
    }
    return $count;
}

for my $test ( [ [3,0,1,1,9,7], [7,2,3] ],
               [ [1,1,2,2,3], [0,0,1] ],
               [ [1,1,2,2,3], [1,1,2] ],
             ) {
    say sprintf "%-15s - xyz = %-10s => %d",
                "@{@$test[0]}", "@{@$test[1]}",
                count_good_triplets @$test;
}
