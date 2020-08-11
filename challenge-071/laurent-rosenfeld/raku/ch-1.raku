use v6;

sub MAIN (Int $n where 1 < * <= 50) {
    my @nums = (1..50).pick: $n;
    say @nums;
    my @peaks = gather {
        for 1..^@nums.end -> $i {
            take @nums[$i] if @nums[$i-1] < @nums[$i] > @nums[$i+1];
        }
    }
    unshift @peaks, @nums[0] if @nums[1] < @nums[0];
    push @peaks, @nums[@nums.end]
        if @nums[@nums.end] > @nums[@nums.end -1];
    say @peaks;
}
