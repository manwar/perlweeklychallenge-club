#! /usr/bin/raku

use Test;

plan 3;

is-deeply(finalprice([8, 4, 6, 2, 3]), [4, 2, 4, 2, 3], 'example 1');
is-deeply(finalprice([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5], 'example 2');
is-deeply(finalprice([7, 1, 1, 5]), [6, 0, 1, 5], 'example 3');

sub finalprice(@a) {
    my @out;
    for @a.kv -> $i, $n {
        my $discount = 0;
        for $i + 1 .. @a.end -> $mi {
            if (@a[$mi] <= $n) {
                $discount = @a[$mi];
                last;
            }
        }
        @out.push($n - $discount);
    }
    @out;
}
