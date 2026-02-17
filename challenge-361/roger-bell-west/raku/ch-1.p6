#! /usr/bin/raku

use Test;

plan 5;

is-deeply(zeckendorfrepresentation(4), [3, 1], 'example 1');
is-deeply(zeckendorfrepresentation(12), [8, 3, 1], 'example 2');
is-deeply(zeckendorfrepresentation(20), [13, 5, 2], 'example 3');
is-deeply(zeckendorfrepresentation(96), [89, 5, 2], 'example 4');
is-deeply(zeckendorfrepresentation(100), [89, 8, 3], 'example 5');

sub zeckendorfrepresentation($a) {
    my @fib = [0, 1];
    while (@fib[*-1] <= $a) {
        @fib.push(@fib[*-1] + @fib[*-2]);
    }
    @fib.pop;
    my @res;
    my $aw = $a;
    while ($aw > 0) {
        @res.push(@fib[*-1]);
        $aw -= @fib[*-1];
        @fib.pop;
        @fib.pop;
        while @fib[*-1] > $aw {
            @fib.pop();
        }
    }
    @res;
}
