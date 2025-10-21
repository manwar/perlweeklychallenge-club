#!/usr/bin/env raku

use v6.d;

sub zero-friend(@nums --> Int) {
    return 0 if 0 ∈ @nums;
    my $above = min(grep({ $_ > 0 }, @nums));
    my $below = max(grep({ $_ < 0 }, @nums));
    return min($above, abs($below))
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is zero-friend([4, 2, -1, 3, -2]), 1, 'works for [4, 2, -1, 3, -2]';
    is zero-friend([-5, 5, -3, 3, -1, 1]), 1, 'works for [-5, 5, -3, 3, -1, 1]';
    is zero-friend([7, -3, 0, 2, -8]), 0, 'works for [7, -3, 0, 2, -8]';
    is zero-friend([-2, -5, -1, -8]), 1, 'works for [-2, -5, -1, -8]';
    is zero-friend([-2, 2, -4, 4, -1, 1]), 1, 'works for [-2, 2, -4, 4, -1, 1]';
}

#| Take user provided numbers 5 9 3 4 6
multi sub MAIN(*@nums) {
    say zero-friend(@nums);
}
