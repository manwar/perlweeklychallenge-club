#! /usr/bin/raku

use Test;

plan 3;

is-deeply(numbergame([2, 5, 3, 4]), [3, 2, 5, 4], 'example 1');
is-deeply(numbergame([9, 4, 1, 3, 6, 4, 6, 1]), [1, 1, 4, 3, 6, 4, 9, 6], 'example 2');
is-deeply(numbergame([1, 2, 2, 3]), [2, 1, 3, 2], 'example 3');

sub numbergame(@a0) {
    my @out;
    my @a = @a0.sort({$^a <=> $^b});
    for @a -> $i, $j {
        @out.push($j);
        @out.push($i);
    }
    return @out;
}
