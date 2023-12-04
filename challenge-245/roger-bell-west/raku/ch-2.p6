#! /usr/bin/raku

use Test;

plan 2;

is(largestofthree([8, 1, 9]), 981, 'example 1');
is(largestofthree([8, 6, 7, 1, 0]), 8760, 'example 2');

sub largestofthree(@digits) {
    my @ordered = @digits.sort({$^b <=> $^a});
    my $mx = 0;
    for (0 .. @ordered.end).reverse -> $n {
        for combinations(@ordered, $n + 1) -> @c {
            my $t = 0;
            for @c -> $d {
                $t *= 10;
                $t += $d;
            }
            if ($t > $mx && $t % 3 == 0) {
                $mx = $t;
            }
        }
    }
    return $mx;
}
