#! /usr/bin/raku

use Test;

plan 2;

is(maximisegreatness([1, 3, 5, 2, 1, 3, 1]), 4, 'example 1');
is(maximisegreatness([1, 2, 3, 4]), 3, 'example 2');

sub maximisegreatness(@a) {
    my @b = @a.sort({$^a <=> $^b});
    my $g = 0;
    for @b -> $c {
        if ($c > @b[$g]) {
            $g++;
        }
    }
    return $g;
}
