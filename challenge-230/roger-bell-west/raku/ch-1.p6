#! /usr/bin/raku

use Test;

plan 2;

is-deeply(separatedigits([1, 34, 5, 6]), [1, 3, 4, 5, 6], 'example 1');
is-deeply(separatedigits([1, 24, 51, 60]), [1, 2, 4, 5, 1, 6, 0], 'example 2');

sub separatedigits(@a) {
    my @out;
    for @a -> $n {
        my $m = $n;
        my @v;
        while ($m > 0) {
            @v.push($m % 10);
            $m div= 10;
        }
        @out.append(@v.reverse);
    }
    return @out;
}
