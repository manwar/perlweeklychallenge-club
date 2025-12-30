use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-354/#TASK1

# Given an array of distinct integers, return all pairs that have the minimum difference
sub min_abs_diff(@ints) {
    @ints = sort { $a <=> $b } @ints;

    my @min_difference_pairs;
    if (@ints) {
        my $min_difference = $ints[-1] - $ints[0] + 1;
        for my $i (0..($#ints-1)) {
            my $difference = $ints[$i+1] - $ints[$i];
            if ($difference <= $min_difference) {
                if ($difference < $min_difference) {
                    $min_difference = $difference;
                    @min_difference_pairs = ();
                }
                push @min_difference_pairs, [$ints[$i], $ints[$i+1]];
            }
        }
    }

    return @min_difference_pairs;
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->encode([min_abs_diff(@$inputs)]) },
        '[4, 2, 1, 3]',
        '{"type":"array", "items":{"type": "integer"}}',
    );
}
