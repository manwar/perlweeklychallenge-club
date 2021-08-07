use v6;

sub find_smallest_diff(@in) {
    my $inbag = @in.Bag;
    my $min_val = Inf;
    my $min_seq;
    my $count = @in.elems div 2;
    for @in.combinations: $count -> @c1 {
        my @c2 = ($inbag (-) @c1.Bag).keys;
        if abs(@c2.sum - @c1.sum) < $min_val {
            $min_val = abs(@c2.sum - @c1.sum);
            $min_seq = (@c1, " -- ", @c2);
        }
    }
    return "$min_seq => $min_val";
}

my @tests = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
            [10, -15, 20, 30, -25, 0, 5, 40, -5];
say find_smallest_diff($_) for @tests;
