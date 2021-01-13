#!/bin/env raku

sub MAIN(*@a) {
    my $min-sum = ∞;
    my $min-num = @a.elems;

    for [X] @a.map:{ -$_, $_ } -> @b {
        my $sum = @b.sum;
        next if $sum < 0;

        my $num-of-negatives = @b.grep({ $_ < 0 }).elems;
        if ($sum < $min-sum or $sum == $min-sum and $num-of-negatives < $min-num) {
            $min-sum = $sum;
            $min-num = $num-of-negatives;
        }
    }

    say "$min-sum, $min-num";
}
