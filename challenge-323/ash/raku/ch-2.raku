# Task 2 of the Weekly Challenge 323
# https://theweeklychallenge.org/blog/perl-weekly-challenge-323

say income-tax 10, [[3, 50], [7, 10], [12, 25]]; # 2.65
say income-tax 2, [[1, 0], [4, 25], [5, 50]];    # 0.25
say income-tax 0, [[2, 50]];                     # 0

sub income-tax($income, @levels) {
    return 0 unless $income;

    my $remainder = $income;
    my $tax = 0;


    my $prev_threshold = 0;
    for @levels -> ($threshold, $rate) {
        my $delta = $threshold - $prev_threshold;

        my $taxable = 0;
        if $remainder > $delta {
            $remainder -= $delta;
            $taxable = $delta;
        }
        else {
            $taxable = $remainder;
            $remainder = 0;
        }        

        $tax += $taxable * $rate / 100;

        $prev_threshold = $threshold;
    }

    return $tax;
}
