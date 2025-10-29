#! /usr/bin/raku

use Test;

plan 5;

is-deeply(lastvisitor([5, -1, -1]), [5, -1], 'example 1');
is-deeply(lastvisitor([3, 7, -1, -1, -1]), [7, 3, -1], 'example 2');
is-deeply(lastvisitor([2, -1, 4, -1, -1]), [2, 4, 2], 'example 3');
is-deeply(lastvisitor([10, 20, -1, 30, -1, -1]), [20, 30, 20], 'example 4');
is-deeply(lastvisitor([-1, -1, 5, -1]), [-1, -1, 5], 'example 5');

sub lastvisitor(@a) {
    my @seen;
    my @ans;
    my $minusones = 0;
    for @a -> $n {
        if ($n == -1) {
            $minusones++;
            if ($minusones <= @seen.elems) {
                @ans.push(@seen[$minusones - 1]);
            } else {
                @ans.push(-1);
            }
        } else {
            @seen.unshift($n);
            $minusones = 0;
        }
    }
    @ans;
}
