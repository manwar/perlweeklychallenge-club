#! /usr/bin/raku

use Test;

plan 3;

is-deeply(sortoddeven([4, 1, 2, 3]), [2, 3, 4, 1], 'example 1');
is-deeply(sortoddeven([3, 1]), [3, 1], 'example 2');
is-deeply(sortoddeven([5, 3, 2, 1, 4]), [2, 3, 4, 1, 5], 'example 3');

sub sortoddeven(@a) {
    my @odds;
    my @evens;
    for @a.kv -> $i, $x {
        if ($i % 2 == 0) {
            @evens.push($x);
        } else {
            @odds.push($x);
        }
    }
    @evens = @evens.sort({$^a <=> $^b});
    @odds = @odds.sort({$^b <=> $^a});
    my @out;
    for 0 .. max(@evens.end, @odds.end) -> $i {
        if ($i <= @evens.end) {
            @out.push(@evens[$i]);
        }
        if ($i <= @odds.end) {
            @out.push(@odds[$i]);
        }
    }
    @out;
}
